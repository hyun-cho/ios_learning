//
//  BookStore.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit

class ServerDataSourceStore {
    private(set) var serverData: [BookRecommendationCellData] = [BookRecommendationCellData]()
    
    private var serverDataStore = ServerDataStore()
    private var serverIdentifierParser = ServerIdentifierParser()
    
    init() {
        //TODO
        let serverRawData: [ServerRawData] = serverDataStore.getDataFromServer()
        
        serverRawData.forEach({
            let cellData = serverIdentifierParser.parse(cellType: $0.cellType , data: $0.data )
            switch cellData {
            case .none:
                break
            default:
                serverData.append(cellData)
            }
        })
    }
}

extension ServerDataSourceStore {
    subscript(indexPath: IndexPath) -> BookRecommendationCellData? {
        guard indexPath.row < serverData.count && indexPath.row >= 0 else {
            return nil
        }
        return serverData[indexPath.row]
    }
}
