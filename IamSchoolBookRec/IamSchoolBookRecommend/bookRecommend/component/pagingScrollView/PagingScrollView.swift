//
//  PagingScrollView.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/24.
//

import UIKit

public class PagingScrollView: UIScrollView {
    @IBOutlet var contentView: UIView!
    
    // directionDelegate에서 수정되는 속성
    @IBOutlet var contentViewEqualHeightConstraint: NSLayoutConstraint!
    @IBOutlet var contentViewEqualWidthConstraint: NSLayoutConstraint!
    @IBOutlet var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var contentViewWidthConstraint: NSLayoutConstraint!
    
    // register protocol 변수 구현
    public var registeredNib: [String: UINib?] = [String: UINib?]()
    public var registeredCell: [String: AnyClass?] = [String: AnyClass?]()
    
    // reusable을 사용해 reuse와 presented View Poll 표현
    public var reuseViewPool: ReusableViewPool<PagingScrollViewCell> = ReusableViewPool<PagingScrollViewCell>()
    private var presentedViewPool: ReusableViewPool<PagingScrollViewCell>?
    
    weak public var layoutDelegate: PagingScrollViewLayoutDelegate?
    weak public var directionDelegate: PagingScrollDirectionDelegate?
    weak public var dataSource: PagingScrollDataSource?
        
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
    }
    
    public override func updateConstraints() {
        super.updateConstraints()
        updateSubviewsConstraints()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateSubviewsFromCurrentOffset()
    }
    
    public func reloadData() {
        // 초기화
        removeAllSubviews()
        
        // 방향과 뷰 크기
        updateScrollDirection()
        updateContentViewSize()
        updateConstraints()
        
        updateSubviewsFromCurrentOffset()
    }
}

// delegate로 부터 받아오는 연산 프로퍼티 정의
extension PagingScrollView {
    var numberOfItems: Int {
        self.dataSource?.pagingScrollView(self, numberOfItems: 0) ?? 0
    }
    var cellSize: CGSize {
        self.layoutDelegate?.pagingScrollView(self, cellSize: CGSize(), index: 0) ?? CGSize(width: 0, height: 0)
    }
    var interItemSpacing: CGFloat {
        self.layoutDelegate?.pagingScrollView(self, interItemSpacing: 20) ?? 0
    }
    var scrollViewContentInsets: UIEdgeInsets {
        self.layoutDelegate?.pagingScrollView(self, contentInsets: UIEdgeInsets()) ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// Content reload 로직
extension PagingScrollView {
    // subview의 모든 constraint와 view를 삭제한다.
    private func removeAllSubviews() {
        self.contentView.subviews.forEach({
            guard let cell = $0 as? PagingScrollViewCell else {
                return
            }
            cell.removeConstraints()
            $0.removeFromSuperview()
        })
        if self.presentedViewPool == nil {
            self.presentedViewPool = ReusableViewPool<PagingScrollViewCell>()
        }
        else {
            self.presentedViewPool?.removeAll()
        }
    }
    
    // 특정 cell을 타겟으로 삭제한다.
    private func removeSubview(cell target: PagingScrollViewCell) {
        self.contentView.subviews.forEach({
            guard let cell = $0 as? PagingScrollViewCell else {
                return
            }
            if cell === target {
                cell.removeConstraints()
                $0.removeFromSuperview()
                reuseViewPool.append(cell)
            }
        })
        presentedViewPool?.remove(element: target)
    }
    
    private func updateScrollDirection() {
        directionDelegate?.updateScrollDirection(self)
    }
    
    private func updateContentViewSize() {
        directionDelegate?.updateContentViewSize(self)
        self.contentInset = scrollViewContentInsets
    }
    
    public func updateSubviewsFromCurrentOffset() {
        let startIndex = directionDelegate?.startIndexOfCurrentContentOffset(self) ?? 0
        let endIndex = directionDelegate?.endIndexOfCurrentContentOffset(self) ?? 0
        
        guard startIndex <= endIndex else {
            fatalError("index out of range in \(#function)")
        }
        
        print("index from \(startIndex) to \(endIndex)")
        print("presentedViewCount \(presentedViewPool!.count)")
        print("reusePoolcount \(reuseViewPool.count)")
        presentedViewPool?.forEach({
            guard let index = $0.index else {
                return
            }
            switch index {
            case startIndex...endIndex:
                return
            default:
                removeSubview(cell: $0)
                print("Removed \(index)")
            }
        })
        for index in startIndex...endIndex {
            guard let _ = presentedViewPool?[index] else {
                appendView(index: index)
                print("Appended \(index)")
                continue
            }
        }
    }
    private func appendView(index: Int) {
        guard let cell = self.dataSource?.pagingScrollView(self, cellForItemAt: index) else {
            return
        }
        cell.index = index
        presentedViewPool?.append(cell)
        self.contentView.addSubview(cell)
        updateSubviewsConstraints()
        return
    }
    
    // subview들의
    private func updateSubviewsConstraints() {
        self.presentedViewPool?.forEach({
            (cell) -> Void in
            guard let index = cell.index,
                  let alignWith = cell.alignWith else {
                return
            }
            if cell.positionConstraint == nil {
                let positionConstraint = self.directionDelegate?.positionConstraint(self, cell: cell, index: index)
                positionConstraint?.isActive = true
                cell.positionConstraint = positionConstraint
            }
            if cell.alignConstraint == nil {
                let alignConstraint = NSLayoutConstraint(item: cell, attribute: alignWith, relatedBy: .equal, toItem: contentView, attribute: alignWith, multiplier: 1.0, constant: 0.0)
                alignConstraint.isActive = true
                cell.alignConstraint = alignConstraint
            }
        })
    }
}

// scroll paging 구현
extension PagingScrollView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateSubviewsFromCurrentOffset()
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        targetContentOffset.pointee = scrollView.contentOffset
    }
}

// 재사용 로직
extension PagingScrollView {
    // reusableCell을 가져온다. 없을시 생성한다.
    func dequeueReusableCell(withIdentifier: String, for index: Int) -> UIView? {
        if reuseViewPool.first == nil {
            guard let cell = self.createCellFromRegistred(withIdentifier: withIdentifier) else {
                return nil
            }
            return cell
        }
        else {
            return reuseViewPool.removeFirst()
        }
    }
    // 새로운 cell을 register pool에서 생성한다.
    func createCellFromRegistred(withIdentifier: String) -> PagingScrollViewCell? {
        if let anyClass = self.registeredCell[withIdentifier] {
            let cls: NSObject.Type = anyClass as! NSObject.Type
            let cell = cls.init() as? PagingScrollViewCell ?? PagingScrollViewCell()
            cell.translatesAutoresizingMaskIntoConstraints = false
            return cell
        }
        if let nib = self.registeredNib[withIdentifier] {
            guard let cell = nib?.instantiate(withOwner: self, options: nil).first as? PagingScrollViewCell else {
                return nil
            }
            cell.translatesAutoresizingMaskIntoConstraints = false
            return cell
        }
        return nil
    }
}

// 재사용 로직을 위해 RegisterNibOrClass 프로토콜에 정의된 register() 메서드를 사용가능하다.
extension PagingScrollView: RegisterNibOrClass {
}
