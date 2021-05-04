//
//  ScrollTypeCViewCellData.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import UIKit

struct ScrollTypeCViewCellData {
    let cellIdentifier = "ScrollTypeCViewCell"
    private(set) var name: String
    private(set) var remoteURL: String?
    
    init(name: String, remoteURL: String) {
        self.name = name
        self.remoteURL = remoteURL
    }
}
