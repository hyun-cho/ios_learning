//
//  PagingScrollDataSource.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/24.
//

import UIKit

public protocol PagingScrollDataSource: NSObjectProtocol {
    func pagingScrollView(_ pagingScrollView: PagingScrollView, numberOfItems: Int) -> Int
    func pagingScrollView(_ pagingScrollView: PagingScrollView, cellForItemAt index: Int) -> PagingScrollViewCell
}

extension PagingScrollDataSource {
    func pagingScrollView(_ pagingScrollView: PagingScrollView, numberOfItems: Int) -> Int {
        return numberOfItems
    }
}
