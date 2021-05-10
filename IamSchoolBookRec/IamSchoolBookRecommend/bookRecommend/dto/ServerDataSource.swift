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
    
    private var needCancel: Bool = false
    
    func fetchCellDatas(completion: @escaping () -> Void) {
        bookRecommendAPI.fetchDataFromServer(completion: {
            [weak self]
            (serverResult: Result<[BookRecommendResponseDto], BookRecommendApiError>) -> Void in
            for _ in 0..<3 {
                if let cellDatas = self?.cellDatas, !cellDatas.isEmpty { break }
                switch serverResult {
                case .success(let serverData):
                    if let serverData = self?.serverIdentifierParser.parse(datas: serverData) {
                        self?.cellDatas.append(contentsOf: serverData)
                        break
                    }
                case .failure(let error):
                    switch error {
                    case .recallApi:
                        print("recall")
                    case .stop:
                        print("asdf")
                    }
                    if let needCancel = self?.needCancel, needCancel {
                        self?.needCancel = false
                        break
                    }
                }
            }
            completion()
        })
    }
    func cancelFetchCellData() {
        bookRecommendAPI.cancel()
        self.needCancel = true
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
