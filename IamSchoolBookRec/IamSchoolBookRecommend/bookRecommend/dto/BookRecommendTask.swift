//
//  BookRecommendTask.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/19.
//

import UIKit

// 어떤 Cell을 그릴것이냐 하는 UI쪽 데이터
enum CellIdentifier: String {
    case StandSlidingCell
    case ButtonNavigationCell
    case CollectionCellTypeA
//    case CollectionCellTypeB
//    case CollectionCellTypeC
    case BookGuideCell
}
 
//
//extension CellIdentifier {
//    var toDataType: String {
//        switch self {
//        case .StandSlidingCell:
//            return "~~"
//        }
//    }
//}

enum BookRecommendationCellData {
    case standSlidingData(StandSlidingData)
    case buttonNavigationCellData(ButtonNavigationCellData)
}

struct StandSlidingData {
    var bookDetails: [BookDetail]
}

struct ButtonNavigationCellData {
    var books: [Book]
}

// 서버에서 DataType -> Cell의 DataType에 캐스팅을 해서 넘겨준다.
// (서버에서의 데이터) 2 -> (UI를 위한 데이터) 1

// BookRecommendType
class BookRecommendTask {
    var section: Int
    var title: String?
    var cellIdentifier: CellIdentifier?
    // class -> struct로 변경
    var dataSource: [Taskable]
    
    init(section: Int, cellIdentifier: CellIdentifier, dataSource: [Taskable]) {
        self.section = section
        self.cellIdentifier = cellIdentifier
        self.dataSource = dataSource
    }
    
    convenience init(section: Int, cellIdentifier: CellIdentifier, dataSource: [Taskable], title: String) {
        self.init(section: section, cellIdentifier: cellIdentifier, dataSource: dataSource)
        self.title = title
    }
}

