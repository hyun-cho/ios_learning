//
//  ServerIdentifierParser.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/21.
//

import UIKit

class ServerIdentifierParser {
    enum CellType: String {
        // 서버에서 내려올 cell type
        // 실제 type에 맞게 변경 필요하다.
        case standSliding,
             buttonNavigation,
             collectionTypeA,
             bookGuide,
             bookScrap,
             bookScrollTypeB,
             bookScrollTypeC
    }

    // data -> 서버에서 올 데이터 타입
    public func parse(cellType: String, data: String) -> BookRecommendationCellData {
        let type = CellType.init(rawValue: cellType)
        switch type {
        case .standSliding:
            // 지금은 데이터를 집어넣지만, data를 파싱해서 StandSlidingData로 파싱
            let standSlidingDatas = StandSlidingData(standSlidingDatas: [
                StandCollectionViewCellData(name: "이유가 있어서 멸종 했습니다. 0", description: "세상에서 가장 재미있는 멸종 동물 도감 0", remoteURL: "https://images-na.ssl-images-amazon.com/images/I/41Q3VqCFCkL._SX322_BO1,204,203,200_.jpg"),
                StandCollectionViewCellData(name: "이유가 있어서 멸종 했습니다. 1", description: "세상에서 가장 재미있는 멸종 동물 도감 1", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/053/l9791164137053.jpg"),
                StandCollectionViewCellData(name: "이유가 있어서 멸종 했습니다. 2", description: "세상에서 가장 재미있는 멸종 동물 도감 2", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/204/l9791197182204.jpg"),
                StandCollectionViewCellData(name: "이유가 있어서 멸종 했습니다. 3", description: "세상에서 가장 재미있는 멸종 동물 도감 3", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/787/l9791163460787.jpg"),
                StandCollectionViewCellData(name: "이유가 있어서 멸종 했습니다. 4", description: "세상에서 가장 재미있는 멸종 동물 도감 4", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/133/l9788953332133.jpg"),
                StandCollectionViewCellData(name: "이유가 있어서 멸종 했습니다. 5", description: "세상에서 가장 재미있는 멸종 동물 도감 5", remoteURL: "https://images-na.ssl-images-amazon.com/images/I/41Q3VqCFCkL._SX322_BO1,204,203,200_.jpg")
            ])
            return BookRecommendationCellData.standSlidingData(standSlidingDatas)
        case .buttonNavigation:
            let buttonDatas = ButtonNavigationData(buttonDatas: [
                NavigationButtonData(title: "교과연계 추천도서", remoteURL: "https://image.toast.com/aaaaaaq/iamschool/test/ICON_MENU/8328052198893806.png"),
//                NavigationButtonData(title: "책 가이드", remoteURL: "https://image.toast.com/aaaaaaq/iamschool/test/ICON_MENU/8328052198893806.png"),
                NavigationButtonData(title: "책 가이드", remoteURL: "https://image.toast.com/aaaaaaq/iamschool/test/ICON_MENU/8328052198893806.png")
            ])
            return BookRecommendationCellData.buttonNavigationData(buttonDatas)
        case .collectionTypeA:
            let bookCollectionCellDatas = BookCollectionTypeAData(title: "신간 추천", collectionViewDatas: [
                CollectionTypeAViewCellData(name: "이유가 있어서 멸종 했습니다. 0", remoteURL: "https://images-na.ssl-images-amazon.com/images/I/41Q3VqCFCkL._SX322_BO1,204,203,200_.jpg"),
                CollectionTypeAViewCellData(name: "이유가 있어서 멸종 했습니다. 1", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/053/l9791164137053.jpg"),
                CollectionTypeAViewCellData(name: "이유가 있어서 멸종 했습니다. 2", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/204/l9791197182204.jpg"),
                CollectionTypeAViewCellData(name: "이유가 있어서 멸종 했습니다. 3", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/787/l9791163460787.jpg"),
                CollectionTypeAViewCellData(name: "이유가 있어서 멸종 했습니다. 4", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/133/l9788953332133.jpg"),
                CollectionTypeAViewCellData(name: "이유가 있어서 멸종 했습니다. 5", remoteURL: "https://images-na.ssl-images-amazon.com/images/I/41Q3VqCFCkL._SX322_BO1,204,203,200_.jpg")
            ])
            return BookRecommendationCellData.bookCollectionTypeAData(bookCollectionCellDatas)
        case .bookGuide:
            let bookGuideData = BookGuideData(title: "청소년이 고민하는 30가지 상담 가이드", description: "청소년기의 보편적인 특성과 상담하는 이에게 필요한 자질 그리고 적극적 경청이라는 상담의 기보자세에 대해 언급~~~~~", remoteURL: "https://charlottesometimesgoestothemovies.files.wordpress.com/2020/03/books.jpg?w=1024&h=717&crop=1")
            return BookRecommendationCellData.bookGuideData(bookGuideData)
        case .bookScrap:
//            let bookScrapData = BookScrapData(title: "스크랩한 책/책 이야기", book: BookScrapData.Book(name: "이유가 있어서 멸종했습니다.", description: "세상에서 가장 재미있는 멸종 동물 도감", remoteURL: "https://images-na.ssl-images-amazon.com/images/I/41Q3VqCFCkL._SX322_BO1,204,203,200_.jpg"))
            let bookScrapData = BookScrapData(title: "스크랩한 책/책 이야기", book: BookScrapData.Book(name: "이유가 있어서 멸종했습니다.", description: "세상에서 가장 재미있는 멸종 동물 도감 1 세상에서 가장 재미있는 멸종 동물 도감 2 세상에서 가장 재미있는 멸종 동물 도감 3 세상에서 가장 재미있는 멸종 동물 도감 4 세상에서 가장 재미있는 멸종 동물 도감 5", remoteURL: "https://images-na.ssl-images-amazon.com/images/I/41Q3VqCFCkL._SX322_BO1,204,203,200_.jpg"))
            return BookRecommendationCellData.bookScrapData(bookScrapData)
        case .bookScrollTypeB:
            let typeBDatas: [BookScrollData.BookScrollCellDataType] = [
                .typeB(ScrollTypeBViewCellData(name: "이유가 있어서 멸종 했습니다. 0", description: "세상에서 가장 재미있는 멸종 동물 도감 0", remoteURL: "https://images-na.ssl-images-amazon.com/images/I/41Q3VqCFCkL._SX322_BO1,204,203,200_.jpg")),
                .typeB(ScrollTypeBViewCellData(name: "이유가 있어서 멸종 했습니다. 1", description: "세상에서 가장 재미있는 명종 동물 도감 1", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/053/l9791164137053.jpg")),
                .typeB(ScrollTypeBViewCellData(name: "이유가 있어서 멸종 했습니다. 2", description: "세상에서 가장 재미있는 멸종 동물 도감 2", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/204/l9791197182204.jpg")),
                .typeB(ScrollTypeBViewCellData(name: "이유가 있어서 멸종 했습니다. 3", description: "세상에서 가장 재미있는 멸종 동물 도감 3", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/787/l9791163460787.jpg")),
                .typeB(ScrollTypeBViewCellData(name: "이유가 있어서 멸종 했습니다. 4", description: "세상에서 가장 재미있는 멸종 동물 도감 4", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/133/l9788953332133.jpg")),
                .typeB(ScrollTypeBViewCellData(name: "이유가 있어서 멸종 했습니다. 5", description: "세상에서 가장 재미있는 멸종 동물 도감 5", remoteURL: "https://images-na.ssl-images-amazon.com/images/I/41Q3VqCFCkL._SX322_BO1,204,203,200_.jpg")),
            ]
//            var resultArray: [BookScrollData.BookScrollCellDataType] = []
//            for _ in 0...1000 {
//                resultArray.append(contentsOf: typeBDatas)
//            }
            let bookScrollTypeBData = BookScrollData(title: "테마 추천", scrollViewDatas: typeBDatas)
            return BookRecommendationCellData.bookScrollData(bookScrollTypeBData)
        case .bookScrollTypeC:
            let bookScrollTypeCData = BookScrollData(title: "도서 랭킹", scrollViewDatas: [
                .typeC(ScrollTypeCViewCellData(name: "이유가 있어서 멸종 했습니다. 0", remoteURL: "https://images-na.ssl-images-amazon.com/images/I/41Q3VqCFCkL._SX322_BO1,204,203,200_.jpg")),
                .typeC(ScrollTypeCViewCellData(name: "이유가 있어서 멸종 했습니다. 1", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/053/l9791164137053.jpg")),
                .typeC(ScrollTypeCViewCellData(name: "이유가 있어서 멸종 했습니다. 2", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/204/l9791197182204.jpg")),
                .typeC(ScrollTypeCViewCellData(name: "이유가 있어서 멸종 했습니다. 3", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/787/l9791163460787.jpg")),
                .typeC(ScrollTypeCViewCellData(name: "이유가 있어서 멸종 했습니다. 4", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/133/l9788953332133.jpg")),
                .typeC(ScrollTypeCViewCellData(name: "이유가 있어서 멸종 했습니다. 5", remoteURL: "https://images-na.ssl-images-amazon.com/images/I/41Q3VqCFCkL._SX322_BO1,204,203,200_.jpg")),
            ])
            return BookRecommendationCellData.bookScrollData(bookScrollTypeCData)
        default:
            return BookRecommendationCellData.none
        }
    }
}

