//
//  BookGuide.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/17.
//

import UIKit

class BookGuide {
    var title: String
    var description: String
    var remoteURL: String
    var image: UIImage?
    
    init(title: String, description: String, remoteURL: String) {
        self.title = title
        self.description = description
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
