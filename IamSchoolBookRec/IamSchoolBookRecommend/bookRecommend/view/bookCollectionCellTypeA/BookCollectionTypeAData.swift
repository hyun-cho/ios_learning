//
//  Book.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/19.
//

import UIKit

struct BookCollectionTypeAData {
    private(set) var cellIdentifier: String = "BookCollectionTypeACell"
    private(set) var title: String
    private(set) var collectionViewDatas: [CollectionTypeAViewCellData]
    
    subscript(indexPath: IndexPath) -> CollectionTypeAViewCellData? {
        guard collectionViewDatas.count >= 1 && indexPath.row >= 0 && indexPath.row < collectionViewDatas.count else {
            return nil
        }
        return collectionViewDatas[indexPath.row]
    }
}
