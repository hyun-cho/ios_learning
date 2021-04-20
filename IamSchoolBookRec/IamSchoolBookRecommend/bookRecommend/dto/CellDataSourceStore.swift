//
//  BookStore.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit

class CellDataSourceStore {
    // index == 순서?
    // section 변수 추가? -> 배열의 순서로
    var tasks: [BookRecommendTask] = [BookRecommendTask]()
    
    // TODO
    // JSON 데이터 정제 및 초기화 과정 필요
    init() {
        // sliding
        tasks.append(BookRecommendTask(section: 0, cellIdentifier: CellIdentifier.init(rawValue: "StandSlidingCell")!, dataSource: [
            BookDetail(name: "이유가 있어서 멸종 했습니다. 0", description: "세상에서 가장 재미있는 명종 동물 도감 0", remoteURL: "https://images-na.ssl-images-amazon.com/images/I/41Q3VqCFCkL._SX322_BO1,204,203,200_.jpg"),
            BookDetail(name: "이유가 있어서 멸종 했습니다. 1", description: "세상에서 가장 재미있는 명종 동물 도감 1)", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/053/l9791164137053.jpg"),
            BookDetail(name: "이유가 있어서 멸종 했습니다. 2", description: "세상에서 가장 재미있는 명종 동물 도감 2)", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/204/l9791197182204.jpg"),
            BookDetail(name: "이유가 있어서 멸종 했습니다. 3", description: "세상에서 가장 재미있는 명종 동물 도감 3)", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/787/l9791163460787.jpg"),
            BookDetail(name: "이유가 있어서 멸종 했습니다. 4", description: "세상에서 가장 재미있는 명종 동물 도감 4)", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/133/l9788953332133.jpg"),
            BookDetail(name: "이유가 있어서 멸종 했습니다. 5", description: "세상에서 가장 재미있는 명종 동물 도감 5)", remoteURL: "https://images-na.ssl-images-amazon.com/images/I/41Q3VqCFCkL._SX322_BO1,204,203,200_.jpg")
        ]))
        tasks.append(BookRecommendTask(section: 1, cellIdentifier: CellIdentifier.init(rawValue: "ButtonNavigationCell")!, dataSource: []))
        tasks.append(BookRecommendTask(section: 2, cellIdentifier: CellIdentifier.init(rawValue: "CollectionCellTypeA")!, dataSource: [
            Book(name: "이유가 있어서 멸종 했습니다. 0", remoteURL: "https://images-na.ssl-images-amazon.com/images/I/41Q3VqCFCkL._SX322_BO1,204,203,200_.jpg"),
            Book(name: "이유가 있어서 멸종 했습니다. 1", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/053/l9791164137053.jpg"),
            Book(name: "이유가 있어서 멸종 했습니다. 2", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/204/l9791197182204.jpg"),
            Book(name: "이유가 있어서 멸종 했습니다. 3", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/787/l9791163460787.jpg"),
            Book(name: "이유가 있어서 멸종 했습니다. 4", remoteURL: "https://simage.kyobobook.co.kr/images/book/large/133/l9788953332133.jpg"),
            Book(name: "이유가 있어서 멸종 했습니다. 5", remoteURL: "https://images-na.ssl-images-amazon.com/images/I/41Q3VqCFCkL._SX322_BO1,204,203,200_.jpg")
        ], title: "신간 추천"))
        tasks.append(BookRecommendTask(section: 3, cellIdentifier: CellIdentifier.init(rawValue: "BookGuideCell")!, dataSource: [
            BookGuide(title: "청소년이 고민하는 30가지 상담 가이드", description: "청소년기의 보편적인 특성과 상담하는 이에게 필요한 자질 그리고 적극적 경청이라는 상담의 기보자세에 대해 언급~~~~~", remoteURL: "https://charlottesometimesgoestothemovies.files.wordpress.com/2020/03/books.jpg?w=1024&h=717&crop=1")
        ]))
        
        //        cell.initBookGuide(bookGuide: BookGuide(title: "국어 실력 UP! ~~~~~", description: "국어 실력과 독서 습관을 ~~~~~~~~~~", remoteURL: "https://charlottesometimesgoestothemovies.files.wordpress.com/2020/03/books.jpg?w=1024&h=717&crop=1"))
    }
    
    subscript(section: Int) -> BookRecommendTask? {
        guard let index = tasks.firstIndex(where: { return $0.section == section }) else {
            return nil
        }
        return tasks[index]
    }
}
