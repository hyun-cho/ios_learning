//
//  PagingScrollDirectionDelegate.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/27.
//

import UIKit

public protocol PagingScrollDirectionDelegate: NSObjectProtocol {
    func updateScrollDirection(_ pagingScrollView: PagingScrollView)
    
    func updateContentViewSize(_ pagingScrollView: PagingScrollView)
    
    func startIndexOfCurrentContentOffset(_ pagingScrollView: PagingScrollView) -> Int
    
    func endIndexOfCurrentContentOffset(_ pagingScrollView: PagingScrollView) -> Int
    
    func positionConstraint(_ pagingScrollView: PagingScrollView, cell: PagingScrollViewCell, index forIndex: Int) -> NSLayoutConstraint
}


