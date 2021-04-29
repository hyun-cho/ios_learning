//
//  PagingScrollCell.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/24.
//

import UIKit

public class PagingScrollViewCell: UIView, Indexable {
    var index: Int?
    
    public enum Align {
        case centerY, bottom
    }
    
    open var alignWith: NSLayoutConstraint.Attribute?
    
    weak open var alignConstraint: NSLayoutConstraint?
    weak open var positionConstraint: NSLayoutConstraint?
    
    public func removeConstraints() {
        self.positionConstraint?.isActive = false
        self.positionConstraint = nil
        self.alignConstraint?.isActive = false
        self.alignConstraint = nil
    }
}
