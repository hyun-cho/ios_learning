//
//  BookGuide.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/17.
//

import UIKit

struct BookGuideData: ImageLoader {
    let cellIdentifier: String = "BookGuideCell"
    
    private(set) var title: String
    private(set) var description: String
    
    private(set) var image: UIImage?
    
    init(title: String, description: String, remoteURL: String) {
        self.title = title
        self.description = description
        
        loadImage(remoteURL) {
            (imageResult) -> Void in
            image = imageResult
        }
    }
}
