//
//  ModelMapper.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/30.
//

import Foundation
import BookRecommendData

class ModelMapper {
    func map(from: BookRecommendResponseDto) -> BookRecommendationCellData {
        switch from {
        case .mainSliderType(let mainSliderDatas):
            return .standSlidingData(standSlidingData(from: mainSliderDatas))
        case .buttonType(let buttonDatas):
            return .buttonNavigationData(buttonNavigationData(from: buttonDatas))
        case .gridType(let gridDatas):
            return .bookCollectionData(bookCollectionData(from: gridDatas))
        case .magazineBigType(let magazineBigData):
            return .bookGuideData(bookGuideData(from: magazineBigData))
        case .bookmarkType(let bookmarkData):
            return .bookScrapData(bookScrapData(from: bookmarkData))
        case .middleSliderType(let middleSliderDatas):
            return .bookScrollData(bookScrollData(from: middleSliderDatas))
        case .smallSliderType(let smallSliderDatas):
            return .bookScrollData(bookScrollData(from: smallSliderDatas))
        case .searchTagType(_):
            return .none
//            return .searchTagData(SearchTagData(from: searchTagData))
        case .none:
            return .none
        }
    }
    
    func standSlidingData(from: MainSliderData) -> StandSlidingData {
        let standSlidingDatas = from.items.map({ return StandCollectionViewCellData(name: $0.title , description: $0.content, remoteURL: $0.image) })
        return StandSlidingData(standSlidingDatas: standSlidingDatas)
    }
    
    func buttonNavigationData(from: ButtonData) -> ButtonNavigationData {
        let buttonDatas = from.items.map({ return NavigationButtonData(title: $0.title, remoteURL: $0.image) })
        return ButtonNavigationData(buttonDatas: buttonDatas)
    }
    
    func bookCollectionData(from: GridData) -> BookCollectionData {
        let colllectionViewDatas = from.items.map({ return CollectionViewCellData(name: $0.title, remoteURL: $0.image) })
        return BookCollectionData(title: from.title, collectionViewDatas: colllectionViewDatas)
    }
    func bookGuideData(from: MagazineBigData) -> BookGuideData {
        guard let item = from.items.first else {
            return BookGuideData(title: "", description: "", remoteURL: "")
        }
        return BookGuideData(title: item.title, description: item.content, remoteURL: item.image)
    }
    func bookScrapData(from: BookMarkData) -> BookScrapData {
        let book = BookScrapData.Book(name: "스크랩 타이틀", description: "스크랩 데이터", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/053/l9791164137053.jpg")
        return BookScrapData(title: from.title, book: book)
    }
    func bookScrollData(from: MiddleSliderData) -> BookScrollData {
        let bookScrollCellDataTypeB: [BookScrollData.BookScrollCellDataType] = from.items.map({ return .typeB(ScrollTypeBViewCellData(name: $0.title, description: $0.content, remoteURL: $0.image)) })
        return BookScrollData(title: from.title, scrollViewDatas: bookScrollCellDataTypeB)
    }
    func bookScrollData(from: SmallSliderData) -> BookScrollData {
        let bookScrollCellDataTypeC: [BookScrollData.BookScrollCellDataType] = from.items.map({ return .typeC(ScrollTypeCViewCellData(name: $0.title, remoteURL: $0.image)) })
        return BookScrollData(title: from.title, scrollViewDatas: bookScrollCellDataTypeC)
    }
//    func searchTagData(from: SearchTagData) {
//        return searchTagData(title: from.title, )
//    }
}
