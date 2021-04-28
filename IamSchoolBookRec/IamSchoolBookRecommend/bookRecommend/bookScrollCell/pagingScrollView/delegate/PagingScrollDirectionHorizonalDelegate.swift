//
//  HorizonalPagingScrollDirectionDelegate.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/27.
//

import UIKit

public protocol PagingScrollDirectionHorizonalDelegate: PagingScrollDirectionDelegate {
    
}
extension PagingScrollDirectionHorizonalDelegate {
    public func updateScrollDirection(_ pagingScrollView: PagingScrollView) {
        pagingScrollView.contentViewEqualWidthConstraint.priority = UILayoutPriority(750)
        pagingScrollView.contentViewEqualHeightConstraint.priority = UILayoutPriority(1000)
    }
    
    public func updateContentViewSize(_ pagingScrollView: PagingScrollView) {
        let cellSize = pagingScrollView.cellSize
        let interItemSpacing = pagingScrollView.interItemSpacing
        let numberOfItems = pagingScrollView.numberOfItems
        
        pagingScrollView.contentViewHeightConstraint.constant = cellSize.height
        pagingScrollView.contentViewWidthConstraint.constant = cellSize.width * CGFloat(numberOfItems) + interItemSpacing * CGFloat(numberOfItems - 1)
    }
    
    public func startIndexOfCurrentContentOffset(_ pagingScrollView: PagingScrollView) -> Int {
        let interItemSpacing = pagingScrollView.interItemSpacing
        let cellSize = pagingScrollView.cellSize
        return Int(floor(pagingScrollView.contentOffset.x / (cellSize.width + interItemSpacing)))
    }
    
    public func endIndexOfCurrentContentOffset(_ pagingScrollView: PagingScrollView) -> Int {
        let interItemSpacing = pagingScrollView.interItemSpacing
        let cellSize = pagingScrollView.cellSize
        return Int(floor((pagingScrollView.contentOffset.x + pagingScrollView.frame.width) / (cellSize.width + interItemSpacing)))
    }
        
    public func positionConstraint(_ pagingScrollView: PagingScrollView, cell: PagingScrollViewCell, index forIndex: Int) -> NSLayoutConstraint {
        let contentView = pagingScrollView.contentView
        let cellSize = pagingScrollView.cellSize
        let interItemSpacing = pagingScrollView.interItemSpacing
        return NSLayoutConstraint(item: cell, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: (cellSize.width + interItemSpacing) * CGFloat(forIndex))
    }
}
