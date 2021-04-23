//
//  NavigationButtonData.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/21.
//

import UIKit

struct NavigationButtonData: ImageLoader {
    private(set) var title: String
    private(set) var image: UIImage?
    
    init(title: String, remoteURL: String) {
        self.title = title
        
        loadImage(remoteURL) {
            (imageResult) -> Void in
            image = imageResult
        }
    }
}
