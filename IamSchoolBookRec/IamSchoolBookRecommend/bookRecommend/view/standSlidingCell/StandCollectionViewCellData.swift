//
//  Book.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit



// standSliding을 위한 Data -> 
struct StandCollectionViewCellData: ImageLoader {
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
