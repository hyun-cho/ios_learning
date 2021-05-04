//
//  ServerDataSource.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/30.
//

import Foundation
import BookRecommendData

class ServerDataSource {
    private var cellDatas: [BookRecommendationCellData] = []
    private let bookRecommendAPI: BookRecommendAPI = BookRecommendAPI()
    private let serverIdentifierParser: ServerIdentifierParser = ServerIdentifierParser()
    
    init() {
        
    }
    func fetchCellDatas(completion: @escaping () -> Void) {
        bookRecommendAPI.fetchDataFromServer(completion: {
            [weak self]
            (serverData) -> Void in
            self?.cellDatas.append(contentsOf: self?.serverIdentifierParser.parse(datas: serverData) ?? [])
            completion()
        })
    }
    
    var cellDataCount: Int {
        cellDatas.count
    }
        
    subscript(indexPath: IndexPath) -> BookRecommendationCellData? {
        guard !cellDatas.isEmpty,
              indexPath.row < cellDatas.count,
              indexPath.row >= 0 else {
                return nil
              }
        return cellDatas[indexPath.row]
    }
}
