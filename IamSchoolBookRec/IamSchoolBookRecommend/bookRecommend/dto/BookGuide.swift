//
//  BookGuide.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/17.
//

import UIKit

class BookGuide: Taskable {
    private(set) var title: String
    private(set) var description: String
    private(set) var remoteURL: String {
        didSet {
            let url = URL(string: remoteURL)
            do {
                let data = try Data(contentsOf: url!)
                image = UIImage(data: data)
            } catch {
                print("book image load error")
            }
        }
    }
    
    private(set) var image: UIImage?
    
    init(title: String, description: String, remoteURL: String) {
        self.title = title
        self.description = description
        self.remoteURL = remoteURL
    }
}
