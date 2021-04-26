//
//  PagingScrollCell.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/24.
//

import UIKit

public class UIPagingScrollViewCell: UIView {
    public enum Align {
        case centerY, bottom
    }
    open var alignWithSuperview: Align?
    open var maxSize: CGSize?
    open var leadingConstraint: NSLayoutConstraint?
    
    open var scrollDirection: ScrollDirection?
    open var interItemSpacing: CGFloat?
    open var index: Int?
    
    public func prepareForReuse() {
        print("scroll view cell prepare for reuse")
        self.constraints.forEach({ $0.isActive = false })
        self.removeConstraints(self.constraints)
    }
}
