//
//  BookRecommendRequestDto.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/28.
//

import Foundation

public enum BookRecommendResponseDto: Decodable {
    // decode
    public init(from decoder: Decoder) throws {
        do {
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
        } catch {
            self = .none
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
    case none
    
    
    
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
