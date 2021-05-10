//
//  SearchTagData.swift
//  BookRecommendData
//
//  Created by NHN on 2021/04/30.
//

import Foundation
public struct SearchTagData: Decodable {
    public private(set) var component: String
    public private(set) var title: String
    public private(set) var items: [SearchTagData.Item]
    public struct Item: Decodable {
        public private(set) var title: String
        public private(set) var tags: [Tag]
        public private(set) var inputValue: String
    }
    public struct Tag: Decodable {
        public private(set) var name: String
    }
}
