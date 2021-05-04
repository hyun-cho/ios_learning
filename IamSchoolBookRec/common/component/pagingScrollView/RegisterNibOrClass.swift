//
//  ReusableView.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/24.
//

import UIKit

public protocol RegisterNibOrClass {
    var registeredNib: [String: UINib?] { get set }
    var registeredCell: [String: AnyClass?] { get set }
}

extension RegisterNibOrClass {
    mutating func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String){
        self.registeredCell.updateValue(cellClass, forKey: identifier)
    }

    mutating func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        self.registeredNib.updateValue(nib, forKey: identifier)
    }
}
