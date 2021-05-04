//
//  BookmarkData.swift
//  BookRecommendData
//
//  Created by NHN on 2021/04/30.
//

import Foundation
public struct BookMarkData: Decodable {
    public private(set) var component: String
    public private(set) var title: String
    public private(set) var subject_ids: [String]
}
