//
//  PagingScrollView.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/24.
//

import UIKit

//hor, ver 분리
public class UIPagingScrollView: UIScrollView {
    @IBOutlet var contentView: UIView!
    
    // scrollDirection 조절
    @IBOutlet var contentViewEqualHeightConstraint: NSLayoutConstraint!
    @IBOutlet var contentViewEqualWidthConstraint: NSLayoutConstraint!
    
    // constraint를 통해 contentSize를 조정한다.
    @IBOutlet var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var contentViewWidthConstraint: NSLayoutConstraint!
    
    // reusable protocol 변수 구현
    public var reuseViewPool: [UIView] = [UIView]()
    public var registeredNib: [String: UINib?] = [String: UINib?]()
    public var registeredCell: [String: AnyClass?] = [String: AnyClass?]()
    
    // weak -> 순환
    public var layoutDelegate: UIPagingScrollViewLayoutDelegate?
    public var dataSource: UIPagingScrollDataSource?
    
    private var scrollStartPage: Int = 0 {
        didSet {
            if scrollStartPage < 0 {
                scrollStartPage = 0
            }
            if let numberOfItems = dataSource?.scrollViewNumberOfItems(self) {
                if scrollStartPage >= numberOfItems {
                    scrollStartPage = numberOfItems
                }
            }
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
    }
    
    public func reloadData() {
        removeAllSubviews()
        updateScrollDirection()
        updateSubviewsFromCurrentOffset()
        updateContentViewSize()
        updateConstraints()
    }
}



// Content reload 로직
extension UIPagingScrollView {
    // subview의 모든 constraint와 view를 삭제한다.
    private func removeAllSubviews() {
        contentView.subviews.forEach({
            $0.constraints.forEach({ $0.isActive = false })
            $0.removeFromSuperview()
        })
    }
    
    private func updateScrollDirection() {
        guard let scrollDirection = self.layoutDelegate?.scrollDirection else {
            return
        }
        switch scrollDirection {
        // equal Width, equal Height로 스크롤의 방향을 정한다.
        // equalWidth.priority = 1000 : horizon
        // equalHeight.priority = 1000 : vertical
        case .horizon:
            contentViewEqualHeightConstraint.priority = UILayoutPriority(1000)
            contentViewEqualWidthConstraint.priority = UILayoutPriority(750)
        case .vertical:
            contentViewEqualHeightConstraint.priority = UILayoutPriority(750)
            contentViewEqualWidthConstraint.priority = UILayoutPriority(1000)
        }
    }
    
    private func updateContentViewSize() {
        guard let cell = self.dataSource?.scrollView(self, cellForItemAt: 0),
              let numberOfItems = self.dataSource?.scrollViewNumberOfItems(self),
              let scrollDirection = self.layoutDelegate?.scrollDirection,
              let layoutDelegate = self.layoutDelegate else {
            contentViewHeightConstraint.constant = 0
            contentViewWidthConstraint.constant = 0
            return
        }
        switch scrollDirection {
        case .horizon:
            contentViewHeightConstraint.constant = cell.maxSize?.height ?? cell.frame.height
            contentViewWidthConstraint.constant = cell.frame.width * CGFloat(numberOfItems) +
                layoutDelegate.interItemSpacing * CGFloat(numberOfItems - 1)
        case .vertical:
            contentViewHeightConstraint.constant = cell.frame.height * CGFloat(numberOfItems) +
                layoutDelegate.interItemSpacing * CGFloat(numberOfItems - 1)
            contentViewWidthConstraint.constant = cell.maxSize?.width ?? cell.frame.width
        }
        self.contentInset = layoutDelegate.scrollViewContentInsets
    }
    
    private func updateSubviewsFromCurrentOffset() {
        guard let cell = self.dataSource?.scrollView(self, cellForItemAt: 0),
              let scrollDirection = self.layoutDelegate?.scrollDirection,
              let layoutDelegate = self.layoutDelegate else {
            return
        }
        reuseViewPool.append(cell)

        var startIndex: Int = 0
        var endIndex: Int = 0
        switch scrollDirection {
        case .horizon:
            startIndex = Int(floor(self.contentOffset.x / (cell.frame.width + layoutDelegate.interItemSpacing)))
            endIndex = startIndex + Int(ceil(self.frame.width / cell.frame.width))
        case .vertical:
            startIndex = Int(self.contentOffset.y / floor(cell.frame.height + layoutDelegate.interItemSpacing))
            endIndex = startIndex + Int(ceil(self.frame.height / cell.frame.height))
        }
        
        // 매 point 계산을 하되, 해당 셀만 그때그때 구현.
        //
        
        for index in startIndex..<endIndex {
            guard let cell = self.dataSource?.scrollView(self, cellForItemAt: index) else {
                continue
            }
            cell.index = index
            self.contentView.addSubview(cell)
        }
    }
    
    public override func updateConstraints() {
        super.updateConstraints()
        guard let scrollDirection = self.layoutDelegate?.scrollDirection,
              let layoutDelegate = self.layoutDelegate else {
            return
        }
        self.contentView.subviews.forEach({
            guard let cell = $0 as? UIPagingScrollViewCell,
                  let index = cell.index,
                  let alignWithSuperview = cell.alignWithSuperview else {
                return
            }
            switch scrollDirection {
            case .horizon:
                let leadingConstraint = NSLayoutConstraint(item: cell, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: (cell.frame.size.width + layoutDelegate.interItemSpacing) * CGFloat(index))
                cell.leadingConstraint = leadingConstraint
                leadingConstraint.isActive = true
                
            case .vertical:
                cell.leadingConstraint = NSLayoutConstraint(item: cell, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: (cell.frame.width + layoutDelegate.interItemSpacing) * CGFloat(index))
                cell.leadingConstraint!.isActive = true
            }
            switch alignWithSuperview {
            case .centerY:
                NSLayoutConstraint(item: cell, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
            case .bottom:
                NSLayoutConstraint(item: cell, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
            }
        })
    }
}

// 재사용 로직
extension UIPagingScrollView: ReusableView {
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
    func createCellFromRegistred(withIdentifier: String) -> UIPagingScrollViewCell? {
        if let anyClass = self.registeredCell[withIdentifier] {
            let cls: NSObject.Type = anyClass as! NSObject.Type
            let cell = cls.init() as? UIPagingScrollViewCell ?? UIPagingScrollViewCell()
            cell.translatesAutoresizingMaskIntoConstraints = false
            return cell
        }
        if let nib = self.registeredNib[withIdentifier] {
            guard let cell = nib?.instantiate(withOwner: self, options: nil).first as? UIPagingScrollViewCell else {
                return nil
            }
            cell.translatesAutoresizingMaskIntoConstraints = false
            return cell
        }
        return nil
    }
}

// scroll paging 구현
extension UIPagingScrollView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 최소 단위로 이벤트가 아닌, 속도에 따른 이벤트
        guard let cell = self.dataSource?.scrollView(self, cellForItemAt: 0),
              let scrollDirection = self.layoutDelegate?.scrollDirection,
              let layoutDelegate = self.layoutDelegate else {
            return
        }
        var itemSize: CGFloat = 0
        var leftOffset: CGFloat = 0
        var rightOffset: CGFloat = 0
        switch scrollDirection {
        case .horizon:
            itemSize = cell.frame.width + layoutDelegate.interItemSpacing
            leftOffset = scrollView.contentOffset.x
            rightOffset = scrollView.contentOffset.x + scrollView.frame.width
        case .vertical:
            itemSize = cell.frame.height + layoutDelegate.interItemSpacing
            leftOffset = scrollView.contentOffset.y
            rightOffset = scrollView.contentOffset.y + scrollView.frame.height
        }
        if abs(leftOffset.truncatingRemainder(dividingBy: itemSize)) == 0 ||
            abs(rightOffset.truncatingRemainder(dividingBy: itemSize)) == 30 {
            // 삭제 후 didscroll
            reloadData()
        }
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
    }
    
//    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        guard let cell = self.dataSource?.scrollView(self, cellForItemAt: 0),
//              let scrollDirection = self.layoutDelegate?.scrollDirection,
//              let layoutDelegate = self.layoutDelegate else {
//            return
//        }
//        let itemWidth = cell.frame.width + layoutDelegate.interItemSpacing
//        if abs(scrollView.contentOffset.x - CGFloat(scrollStartPage) * itemWidth) < 10 {
//            scrollView.setContentOffset(CGPoint(x: CGFloat(scrollStartPage) * itemWidth + layoutDelegate.scrollViewContentInsets.left, y: 0), animated: true)
//        }
//        else if scrollView.contentOffset.x > CGFloat(scrollStartPage) * itemWidth {
//            scrollStartPage = Int(ceil(scrollView.contentOffset.x / itemWidth))
//        }
//        else if scrollView.contentOffset.x < CGFloat(scrollStartPage) * itemWidth {
//            scrollStartPage = Int(floor(scrollView.contentOffset.x / itemWidth))
//        }
//        scrollView.setContentOffset(CGPoint(x: CGFloat(scrollStartPage) * itemWidth - layoutDelegate.scrollViewContentInsets.left, y: 0), animated: true)
//        reloadData()
//    }
}
