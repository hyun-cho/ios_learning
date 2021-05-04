//
//  ServerIdentifierParser.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/21.
//

import UIKit
import BookRecommendData

class ServerIdentifierParser {
    private let modelMapper = ModelMapper()
    
    public func parse(datas cellDatas: [BookRecommendResponseDto]?) -> [BookRecommendationCellData]? {
        return cellDatas?.map({ return modelMapper.map(from: $0) })
    }
}
