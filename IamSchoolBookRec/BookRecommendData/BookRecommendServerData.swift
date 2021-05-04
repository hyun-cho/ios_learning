//
//  ServerDataStore.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/21.
//

import UIKit

public class BookRecommendServerData {
    private let bookRecommendAPI: BookRecommendAPI = BookRecommendAPI()
    
    public var serverData: [BookRecommendResponseDto]?
    public init() {

    }
    
    public func fetchServerData(completion: @escaping (Result<[BookRecommendResponseDto]?, ApiError>) -> Void) {
        bookRecommendAPI.fetchDataFromServer(completion: completion)
    }
    
    func fetchDataFromJson(){
        let json = """
        [{
            "component": "iam-main-slider",
            "title": "아이엠스쿨 추천 도서",
            "items": [{
                "title": "어린이를 위한 배 세계사 100",
                "content": "배를 통해 알아보는 세계 역사",
                "link": "iamschoolapp://green-book/articles/1293643",
                "image": "http://image.toast.com/aaaaaaq/iamschool/test/ICON_MENU/138134106667925640.jpg",
                "width": 458,
                "height": 627
            }, {
                "title": "단위 기호사전(과학과 공학의 기초를 쉽게 정리한)",
                "content": "과학 공부, 기초부터 시작하고 싶다면",
                "link": "iamschoolapp://green-book/articles/1293647",
                "image": "http://image.toast.com/aaaaaaq/iamschool/test/ICON_MENU/138134064527729953.jpg",
                "width": 458,
                "height": 650
            }, {
                "title": "내가 김소연진아일동안",
                "content": "학교생활을 간접 체험하고 싶다면",
                "link": "iamschoolapp://green-book/articles/1293640",
                "image": "http://image.toast.com/aaaaaaq/iamschool/test/ICON_MENU/135836011064382341.jpg",
                "width": 458,
                "height": 632
            }, {
                "title": "실크로드 역사특급",
                "content": "역사 다큐보다 재미있는 동아시아 이야기",
                "link": "iamschoolapp://green-book/articles/1293627",
                "image": "http://image.toast.com/aaaaaaq/iamschool/test/ICON_MENU/138134034493783513.jpg",
                "width": 458,
                "height": 590
            }, {
                "title": "건방진 장루이와 68일",
                "content": "친구 관계를 알려주는 관계 동화",
                "link": "iamschoolapp://green-book/articles/1293634",
                "image": "http://image.toast.com/aaaaaaq/iamschool/test/ICON_MENU/135836052899888532.jpg",
                "width": 458,
                "height": 631
            }, {
                "title": "어린이 세계 시민 학교",
                "content": "아이를 글로벌한 인재로 키우고 싶다면",
                "link": "iamschoolapp://green-book/articles/1293650",
                "image": "http://image.toast.com/aaaaaaq/iamschool/test/ICON_MENU/135836078573147789.jpg",
                "width": 458,
                "height": 606
            }, {
                "title": "초등 감정 연습",
                "content": "아이의 감정 지능을 쑥쑥 키워주세요",
                "link": "iamschoolapp://green-book/articles/1293642",
                "image": "http://image.toast.com/aaaaaaq/iamschool/test/ICON_MENU/135836219733403998.jpg",
                "width": 458,
                "height": 677,
                "isRecommended": 0
            }, {
                "title": "말하는 대로 글이 되는 우리 아이 첫 글쓰기",
                "content": "글쓰기 숙제가 부담인 아이들에게",
                "link": "iamschoolapp://green-book/articles/1293621",
                "image": "http://image.toast.com/aaaaaaq/iamschool/test/ICON_MENU/138134124470515001.jpg",
                "width": 690,
                "height": 1037
            }, {
                "title": "백년아이",
                "content": "근현대사를 알려주는 저학년 그림책",
                "link": "iamschoolapp://green-book/articles/1293655",
                "image": "http://image.toast.com/aaaaaaq/iamschool/test/ICON_MENU/138133952730475601.jpg",
                "width": 458,
                "height": 582
            }, {
                "title": "참 잘 뽑은 반장",
                "content": "선거와 대표의 개념을 알려주는 초등 동화",
                "link": "iamschoolapp://green-book/articles/1293625",
                "image": "http://image.toast.com/aaaaaaq/iamschool/test/ICON_MENU/138134084209579498.jpg",
                "width": 458,
                "height": 636
            }]
        }, {
            "component": "iam-button",
            "items": [{
                "title": "교과연계 추천도서",
                "link": "iamschoolapp://webview?landingtype=1&webviewtype=3&url=https://school.iamservice.net/schoolbooks",
                "image": "http://image.toast.com/aaaaaaq/iamschool/test/ICON_MENU/8328052198893806.png",
                "width": 96,
                "height": 96
            }, {
                "title": "책 가이드",
                "content": "",
                "link": "iamschoolapp://green-book/board?category=4438&subject=4440&boardName=%EC%B1%85%20%EA%B0%80%EC%9D%B4%EB%93%9C",
                "image": "http://image.toast.com/aaaaaaq/iamschool/test/ICON_MENU/8328012896376554.png",
                "width": 96,
                "height": 96
            }],
            "background_color": "#00ce53",
            "text_color": "#ffffff",
            "title": "버튼 역역"
        }]
        """.data(using: .utf8)!

        do {
            let repos = try JSONDecoder().decode([BookRecommendResponseDto].self, from: json)
//            repos.forEach({print($0)})
//            self.cellDatas = self.serverIdentifierParser.parse(datas: repos)
        } catch let error {
            print("decode failed \(error)")
        }
    }
}
