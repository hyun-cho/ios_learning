//
//  Book.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit

struct StandCollectionViewCellData {
    private(set) var name: String
    private(set) var description: String
    private(set) var remoteURL: String
    
    init(name: String, description: String, remoteURL: String) {
        self.name = name
        self.description = description
        self.remoteURL = remoteURL
    }
}
