//
//  ScrollTypeCViewCellData.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import UIKit

struct ScrollTypeCViewCellData: ImageLoader {
    private(set) var name: String
    private(set) var image: UIImage?
    
    init(name: String, remoteURL: String) {
        self.name = name
        loadImage(remoteURL) {
            (imageResult) -> Void in
            image = imageResult
        }
    }
}
