//
//  BookStore.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit

class ServerDataSourceStore {
    
    private(set) var serverData: [BookRecommendationCellData] = [BookRecommendationCellData]()
    
    private var bookRecommendServerData = BookRecommendServerData(bookRecommendDataDidSet: {
        [weak self]
        (bookRecommendResponseDto: BookRecommendResponseDto) -> Void in
        guard let cellData = self?.serverIdentifierParser.parse(data: bookRecommendResponseDto) else {
            return
        }
        switch cellData {
        case .none:
            break
        default:
            self?.serverData.append(cellData)
        }
    })
    private var serverIdentifierParser = ServerIdentifierParser()
    
}

extension ServerDataSourceStore {
    subscript(indexPath: IndexPath) -> BookRecommendationCellData? {
        guard indexPath.row < serverData.count && indexPath.row >= 0 else {
            return nil
        }
        return serverData[indexPath.row]
    }
}
