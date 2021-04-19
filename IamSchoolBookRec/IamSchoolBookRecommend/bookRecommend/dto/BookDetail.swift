//
//  Book.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit

class BookDetail: Book {
    private(set) var description: String
    
    init(name: String, description: String, remoteURL: String) {
        self.description = description
        super.init(name: name, remoteURL: remoteURL)
    }
}
