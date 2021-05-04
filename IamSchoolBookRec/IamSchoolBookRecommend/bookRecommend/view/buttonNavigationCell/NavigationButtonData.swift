//
//  NavigationButtonData.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/21.
//

import UIKit

struct NavigationButtonData {
    private(set) var title: String
    private(set) var remoteURL: String
    
    init(title: String, remoteURL: String) {
        self.title = title
        self.remoteURL = remoteURL
    }
}
