//
//  Book.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/19.
//

import UIKit

class Book: Taskable {
    private(set) var name: String
    private(set) var remoteURL: String
    private(set) var image: UIImage?
    
    init(name: String, remoteURL: String) {
        self.name = name
        self.remoteURL = remoteURL
        
        let url = URL(string: remoteURL)
        do {
            let data = try Data(contentsOf: url!)
            image = UIImage(data: data)
        } catch {
            print("book image load error")
        }
    }
}
