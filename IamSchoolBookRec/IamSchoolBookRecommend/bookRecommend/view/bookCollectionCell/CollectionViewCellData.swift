//
//  BookCollectionCellData.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/21.
//

import UIKit

struct CollectionViewCellData {
    let cellIdentifier: String = "CollectionViewCell"
    private(set) var name: String
    private(set) var remoteURL: String
    
    init(name: String, remoteURL: String) {
        self.name = name
        self.remoteURL = remoteURL
    }
}
