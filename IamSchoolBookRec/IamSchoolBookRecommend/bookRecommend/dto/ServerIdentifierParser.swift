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
    // data -> 서버에서 올 데이터 타입
    public func parse(datas cellDatas: [BookRecommendResponseDto]?) -> [BookRecommendationCellData]? {
        return cellDatas?.map({ return parse(data: $0) })
    }
    public func parse(data cellData: BookRecommendResponseDto) -> BookRecommendationCellData {
        switch cellData {
        case .mainSliderType(let mainSliderDatas):
            return .standSlidingData(modelMapper.standSlidingData(from: mainSliderDatas))
        case .buttonType(let buttonDatas):
            return .buttonNavigationData(modelMapper.buttonNavigationData(from: buttonDatas))
        case .gridType(let gridDatas):
            return .bookCollectionData(modelMapper.bookCollectionData(from: gridDatas))
        case .magazineBigType(let magazineBigData):
            return .bookGuideData(modelMapper.bookGuideData(from: magazineBigData))
        case .bookmarkType(let bookmarkData):
            return .bookScrapData(modelMapper.bookScrapData(from: bookmarkData))
        case .middleSliderType(let middleSliderDatas):
            return .bookScrollData(modelMapper.bookScrollData(from: middleSliderDatas))
        case .smallSliderType(let smallSliderDatas):
            return .bookScrollData(modelMapper.bookScrollData(from: smallSliderDatas))
        case .searchTagType(_):
            return .none
//            return .searchTagData(SearchTagData(from: searchTagData))
        case .none:
            return .none
        }
    }
}
