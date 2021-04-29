//
//  PagingScrollDirectionVerticalDelegate.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/27.
//

import UIKit

public protocol PagingScrollDirectionVerticalDelegate: PagingScrollDirectionDelegate {
    
}
extension PagingScrollDirectionVerticalDelegate{
    public func updateScrollDirection(_ pagingScrollView: PagingScrollView) {
        pagingScrollView.contentViewEqualWidthConstraint.priority = UILayoutPriority(1000)
        pagingScrollView.contentViewEqualHeightConstraint.priority = UILayoutPriority(750)
    }
    
    public func updateContentViewSize(_ pagingScrollView: PagingScrollView) {
        let cellSize = pagingScrollView.cellSize
        let interItemSpacing = pagingScrollView.interItemSpacing
        let numberOfItems = pagingScrollView.numberOfItems
        
        pagingScrollView.contentViewHeightConstraint.constant = cellSize.height * CGFloat(numberOfItems) + interItemSpacing * CGFloat(numberOfItems - 1)
        pagingScrollView.contentViewWidthConstraint.constant = cellSize.width
    }
    
    public func startIndexOfCurrentContentOffset(_ pagingScrollView: PagingScrollView) -> Int {
        let interItemSpacing = pagingScrollView.interItemSpacing
        let cellSize = pagingScrollView.cellSize
        return Int(floor(pagingScrollView.contentOffset.y / (cellSize.height + interItemSpacing)))
    }
    public func endIndexOfCurrentContentOffset(_ pagingScrollView: PagingScrollView) -> Int {
        let interItemSpacing = pagingScrollView.interItemSpacing
        let cellSize = pagingScrollView.cellSize
        return Int(floor((pagingScrollView.contentOffset.y + pagingScrollView.frame.height) / (cellSize.height + interItemSpacing)))
    }
    
    public func positionConstraint(_ pagingScrollView: PagingScrollView, cell: PagingScrollViewCell, index forIndex: Int) -> NSLayoutConstraint {
        let contentView = pagingScrollView.contentView
        let cellSize = pagingScrollView.cellSize
        let interItemSpacing = pagingScrollView.interItemSpacing
        return NSLayoutConstraint(item: cell, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: (cellSize.height + interItemSpacing) * CGFloat(forIndex))
    }
}
