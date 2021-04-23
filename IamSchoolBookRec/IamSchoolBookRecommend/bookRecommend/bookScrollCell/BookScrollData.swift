//
//  BookScrollData.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import Foundation

struct BookScrollData {
    enum BookScrollCellDataType {
        case typeB(ScrollTypeBViewCellData)
        case typeC(ScrollTypeCViewCellData)
    }
    let cellIdentifier: String = "BookScrollCell"
    private(set) var title: String
    private(set) var scrollViewDatas: [BookScrollCellDataType]
    var dataType: BookScrollCellDataType? {
        get {
            scrollViewDatas.first
        }
    }
    
    subscript(indexPath: IndexPath) -> BookScrollCellDataType? {
        guard scrollViewDatas.count >= 1 && indexPath.row >= 0 && indexPath.row < scrollViewDatas.count else {
            return nil
        }
        return scrollViewDatas[indexPath.row]
    }
}
