//
//  BookRecommendRequestDto.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/28.
//

import Foundation

enum BookRecommendResponseDto: Decodable {
    // decode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let componentType = try container.decode(ComponentType.self, forKey: .component)
        
        switch componentType {
        case .mainSlider:
            self = .mainSliderType(try MainSliderData(from: decoder))
        case .button:
            self = .buttonType(try ButtonData(from: decoder))
        case .grid:
            self = .gridType(try GridData(from: decoder))
        case .magazineBig:
            self = .magazineBigType(try MagazineBigData(from: decoder))
        case .bookmark:
            self = .bookmarkType(try BookMarkData(from: decoder))
        case .middleSlider:
            self = .middleSliderType(try MiddleSliderData(from: decoder))
        case .smallSlider:
            self = .smallSliderType(try SmallSliderData(from: decoder))
        case .searchTag:
            self = .searchTagType(try SearchTagData(from: decoder))
        }
    }
    
    case mainSliderType(MainSliderData)
    case buttonType(ButtonData)
    case gridType(GridData)
    case magazineBigType(MagazineBigData)
    case bookmarkType(BookMarkData)
    case middleSliderType(MiddleSliderData)
    case smallSliderType(SmallSliderData)
    case searchTagType(SearchTagData)
    
    
    
    enum ComponentType: String, Decodable {
        case mainSlider = "iam-main-slider"
        case button = "iam-button"
        case grid = "iam-grid"
        case magazineBig = "iam-magazine-big"
        case bookmark = "iam-bookmark"
        case middleSlider = "iam-middle-slider"
        case smallSlider = "iam-small-slider"
        case searchTag = "search-tag"
    }
    // decode override
    enum CodingKeys : String, CodingKey{
        case component
    }
}

struct MainSliderData: Decodable {
    var component: String
    var title: String
    var items: [MainSliderData.Item]
    
    struct Item: Decodable {
        var title: String
        var content: String
        var link: String
        var image: String
        var width: Int
        var height: Int
    }
}

struct ButtonData: Decodable {
    var component: String
    var items: [ButtonData.Item]
    var title: String
    var background_color: String
    var text_color: String
    
    struct Item: Decodable {
        var title: String
        var content: String?
        var link: String
        var image: String
        var width: Int
        var height: Int
    }
}
struct GridData: Decodable {
    var component: String
    var title: String
    var items: [GridData.Item]
    struct Item: Decodable {
        var title: String
        var content: String
        var link: String
        var image: String
        var width: Int
        var height: Int
    }
}
struct MagazineBigData: Decodable {
    var component: String
    var title: String
    var items: [MagazineBigData.Item]
    struct Item: Decodable {
        var title: String
        var content: String
        var link: String
        var image: String
        var width: Int
        var height: Int
    }
}
struct BookMarkData: Decodable {
    var component: String
    var title: String
    var subject_ids: [String]
}

struct MiddleSliderData: Decodable {
    var component: String
    var title: String
    var items: [MiddleSliderData.Item]
    
    struct Item: Decodable {
        var title: String
        var content: String
        var link: String
        var image: String
        var width: Int
        var height: Int
        var isRecommend: Int?
    }
}
struct SmallSliderData: Decodable {
    var component: String
    var title: String
    var items: [SmallSliderData.Item]
    struct Item: Decodable {
        var title: String
        var content: String
        var link: String
        var image: String
        var width: Int
        var height: Int
    }
}

struct SearchTagData: Decodable {
    var component: String
    var title: String
    var items: [SearchTagData.Item]
    struct Item: Decodable {
        var title: String
        var tags: [Tag]
        var inputValue: String
    }
    struct Tag: Decodable {
        var name: String
    }
}


