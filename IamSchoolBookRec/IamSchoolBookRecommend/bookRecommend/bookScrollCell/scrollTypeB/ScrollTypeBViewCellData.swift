//
//  ScrollViewCellData.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import UIKit

struct ScrollTypeBViewCellData: ImageLoader {
    let cellIdentifier = "ScrollTypeBViewCell"
    private(set) var name: String
    private(set) var description: String
    
    private(set) var image: UIImage?
    
    init(name: String, description: String, remoteURL: String) {
        self.name = name
        self.description = description
        
        loadImage(remoteURL) {
            (imageResult) -> Void in
            image = imageResult
        }
    }
}
