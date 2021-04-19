//
//  BookRecommendTask.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/19.
//

import UIKit

enum CellIdentifier: String {
    case StandSlidingCell
    case ButtonNavigationCell
    case CollectionCellTypeA
//    case CollectionCellTypeB
//    case CollectionCellTypeC
    case BookGuideCell
}

class BookRecommendTask {
    var section: Int
    var cellIdentifier: CellIdentifier?
    var dataSource: [Taskable]
    
    init(section: Int, cellType: CellIdentifier, dataSource: [Taskable]) {
        self.section = section
        self.cellIdentifier = cellType
        self.dataSource = dataSource
    }
}

