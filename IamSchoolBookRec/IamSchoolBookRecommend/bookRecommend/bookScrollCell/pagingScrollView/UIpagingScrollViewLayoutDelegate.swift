//
//  UIpagingScrollViewLayoutDelegate.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/24.
//

import UIKit

public enum ScrollDirection {
    case horizon, vertical
}
// delegate ->
public protocol UIPagingScrollViewLayoutDelegate: UIScrollViewDelegate {
    // direction
    var scrollDirection: ScrollDirection { get }
    
//    // cell size
//    var cellSize: CGSize { get }
    
    // inter ItemSpacing
    var interItemSpacing: CGFloat { get }
    
    // insets
    var scrollViewContentInsets: UIEdgeInsets { get }
}
