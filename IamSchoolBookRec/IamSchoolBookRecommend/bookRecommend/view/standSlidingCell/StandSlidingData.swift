//
//  StandSlidingData.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/21.
//
import UIKit

struct StandSlidingData {
    let cellIdentifier: String = "StandSlidingCell"
    private(set) var standSlidingDatas: [StandCollectionViewCellData]
    
    subscript(index: Int) -> StandCollectionViewCellData? {
        guard !standSlidingDatas.isEmpty && index >= 0 && index < standSlidingDatas.count else {
            return nil
        }
        return standSlidingDatas[index]
    }
}
