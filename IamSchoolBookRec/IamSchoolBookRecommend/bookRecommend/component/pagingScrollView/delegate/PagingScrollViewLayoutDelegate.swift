//
//  pagingScrollViewLayoutDelegate.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/24.
//

import UIKit

public protocol PagingScrollViewLayoutDelegate: UIScrollViewDelegate {
    func pagingScrollView(_ pagingScrollView: PagingScrollView, cellSize: CGSize?, index forIndex: Int) -> CGSize
    
    func pagingScrollView(_ pagingScrollView: PagingScrollView, interItemSpacing: CGFloat) -> CGFloat
    
    func pagingScrollView(_ pagingScrollView: PagingScrollView, contentInsets: UIEdgeInsets) -> UIEdgeInsets
    
}

extension PagingScrollViewLayoutDelegate {
    func pagingScrollView(_ pagingScrollView: PagingScrollView, interItemSpacing: CGFloat) -> CGFloat {
        return interItemSpacing
    }
    
    func pagingScrollView(_ pagingScrollView: PagingScrollView, contentInsets: UIEdgeInsets) -> UIEdgeInsets {
        return contentInsets
    }
    
}
