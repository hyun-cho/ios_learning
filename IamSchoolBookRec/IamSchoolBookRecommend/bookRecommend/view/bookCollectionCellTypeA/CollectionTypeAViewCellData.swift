//
//  BookCollectionTypeACellData.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/21.
//

import UIKit

struct CollectionTypeAViewCellData: ImageLoader {
    let cellIdentifier: String = "CollectionTypeAViewCell"
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
