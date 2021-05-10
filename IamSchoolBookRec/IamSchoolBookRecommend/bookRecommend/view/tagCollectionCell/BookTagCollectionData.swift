//
//  BookTagCollectionData.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/05/06.
//

import Foundation

struct BookTagCollectionData {
    let cellIdentifier = "BookTagCollectionCell"
    
    private(set) var title: String
    private(set) var tags: [TagCollectionData]
}
