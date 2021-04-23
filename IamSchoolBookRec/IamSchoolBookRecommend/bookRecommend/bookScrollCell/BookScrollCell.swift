//
//  BookScrollCell.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import UIKit
class BookScrollCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bookScrollView: UIScrollView!
    @IBOutlet var innerView: UIView!

    @IBOutlet var innerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var innerViewWidthConstraint: NSLayoutConstraint!
    
    private let typeBSideImageWidth: CGFloat = 63
    
    private var leadingMargin: CGFloat {
        get {
            titleLabel.frame.origin.x
        }
    }
    private var typeBCellWidth: CGFloat {
        get {
            bookScrollView.frame.width - typeBSideImageWidth - leadingMargin * 2
        }
    }
    private var typeCCellWidth: CGFloat {
        get {
            CGFloat(108)
        }
    }
    lazy private var reuseViewPool: [UIView] = [UIView]()
    
    var viewModel: BookScrollData? {
        didSet {
            removeAllSubviews(from: bookScrollView)
            guard let title = viewModel?.title,
                  let cellDataType = viewModel?.dataType,
                  let cellDatas = viewModel?.scrollViewDatas else {
                return
            }
            titleLabel.text = title
            
            updateCellData(type: cellDataType, datas: cellDatas)
        }
    }
    func updateCellData(type cellDataType: BookScrollData.BookScrollCellDataType, datas cellDatas: [BookScrollData.BookScrollCellDataType]) {
        switch cellDataType {
        case .typeB(_):
            self.innerViewWidthConstraint.constant = CGFloat(cellDatas.count) * (typeBCellWidth) + typeBSideImageWidth
            for index in 0...5 {
                guard let cell = dequeueReusableCell(with: cellDatas, for: IndexPath(row: index, section: 0)) as? ScrollTypeBViewCell else {
                    return
                }
                innerView.addSubview(cell)
                cell.leadingConstant = leadingMargin
                cell.updateConstraints(leading: innerView, centerY: innerView, index: index)
                if index == 0 {
                    innerViewHeightConstraint.constant = cell.cellHeight
                }
            }
            
        case .typeC(_):
            self.innerViewWidthConstraint.constant = CGFloat(cellDatas.count) * (typeCCellWidth + leadingMargin)
            for index in 0...5 {
                guard let cell = dequeueReusableCell(with: cellDatas, for: IndexPath(row: index, section: 0)) as? ScrollTypeCViewCell else {
                    return
                }
                innerView.addSubview(cell)
                cell.leadingConstant = leadingMargin
                cell.updateConstraints(leading: innerView, bottom: innerView, index: index)
                if index == 0 {
                    innerViewHeightConstraint.constant = cell.cellHeight
                }
            }
            
        }
        updateConstraintsIfNeeded()
    }
}

extension BookScrollCell {
    private func removeAllSubviews(from: UIScrollView) {
        innerView.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    private func dequeueReusableCell(with cellDatas: [BookScrollData.BookScrollCellDataType]?, for indexPath: IndexPath) -> UIView? {
        guard let cellData = cellDatas?[indexPath.row] else {
            return nil
        }
        
        switch cellData {
        case .typeB(let scrollTypeBData):
            if reuseViewPool.isEmpty {
                return ScrollTypeBViewCell.create(bookData: scrollTypeBData, cellWidth: typeBCellWidth, leadingConstant: leadingMargin)
            }
            guard let cell = reuseViewPool.removeFirst() as? ScrollTypeBViewCell else {
                return ScrollTypeBViewCell.create(bookData: scrollTypeBData, cellWidth: typeBCellWidth, leadingConstant: leadingMargin)
            }
            cell.viewModel = scrollTypeBData
            cell.leadingConstraint.constant = typeBCellWidth * CGFloat(indexPath.row) + leadingMargin
            return cell
        case .typeC(let scrollTypeCData):
            if reuseViewPool.isEmpty {
                return ScrollTypeCViewCell.create(bookData: scrollTypeCData, cellWidth: typeCCellWidth, leadingConstant: leadingMargin)
            }
            guard let cell = reuseViewPool.removeFirst() as? ScrollTypeCViewCell else {
                return ScrollTypeCViewCell.create(bookData: scrollTypeCData, cellWidth: typeCCellWidth, leadingConstant: leadingMargin)
            }
            
            cell.viewModel = scrollTypeCData
            cell.leadingConstraint?.constant = typeBCellWidth * CGFloat(indexPath.row)
            return cell
        }
    }
}

extension BookScrollCell: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) // any offset changes
//
//    // called on start of dragging (may require some time and or distance to move)
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
//
//    // called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
//
//    // called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
//
//    //    @available(iOS 2.0, *)
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) // called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
//
//    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView)
}

