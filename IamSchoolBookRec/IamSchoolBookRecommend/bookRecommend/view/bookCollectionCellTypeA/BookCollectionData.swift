//
//  Book.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/19.
//

import UIKit

struct BookCollectionData {
    private(set) var cellIdentifier: String = "BookCollectionCell"
    private(set) var title: String
    private(set) var collectionViewDatas: [CollectionViewCellData]
    
    subscript(indexPath: IndexPath) -> CollectionViewCellData? {
        guard collectionViewDatas.count >= 1 && indexPath.row >= 0 && indexPath.row < collectionViewDatas.count else {
            return nil
        }
        return collectionViewDatas[indexPath.row]
    }
}
