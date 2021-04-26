//
//  PagingScrollDataSource.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/24.
//

import UIKit

public protocol UIPagingScrollDataSource {
    func scrollViewNumberOfItems(_ pagingScrollView: UIPagingScrollView) -> Int
    func scrollView(_ pagingScrollView: UIPagingScrollView, cellForItemAt index: Int) -> UIPagingScrollViewCell
}
