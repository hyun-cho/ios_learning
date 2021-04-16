//
//  Book.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit

class Book {
    var name: String
    var description: String
    var remoteURL: String
    
    var image: UIImage?
    
    init(name: String, description: String, remoteURL: String) {
        self.name = name
        self.description = description
        self.remoteURL = remoteURL
    }
}
