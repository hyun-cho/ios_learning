//
//  ScrapBookCell.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import UIKit

struct BookScrapData {
    let cellIdentifier: String = "BookScrapCell"
    private(set) var title: String
    private(set) var book: Book
    
    struct Book: ImageLoader {
        private(set) var name: String
        private(set) var description: String
        private(set) var remoteURL: String
        
        private(set) var image: UIImage?
        
        init(name: String, description: String, remoteURL: String) {
            self.name = name
            self.description = description
            self.remoteURL = remoteURL
            
            loadImage(remoteURL) {
                (imageResult) -> Void in
                image = imageResult
            }
        }
    }

}

