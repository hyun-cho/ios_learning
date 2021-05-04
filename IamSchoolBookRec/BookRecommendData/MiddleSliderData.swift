//
//  MiddleSliderData.swift
//  BookRecommendData
//
//  Created by NHN on 2021/04/30.
//

import Foundation
public struct MiddleSliderData: Decodable {
    public private(set) var component: String
    public private(set) var title: String
    public private(set) var items: [MiddleSliderData.Item]
    
    public struct Item: Decodable {
        public private(set) var title: String
        public private(set) var content: String
        public private(set) var link: String
        public private(set) var image: String
        public private(set) var width: Int
        public private(set) var height: Int
        public private(set) var isRecommend: Int?
    }
}
