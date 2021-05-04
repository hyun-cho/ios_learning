//
//  SearchTagData.swift
//  BookRecommendData
//
//  Created by NHN on 2021/04/30.
//

import Foundation
public struct SearchTagData: Decodable {
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
