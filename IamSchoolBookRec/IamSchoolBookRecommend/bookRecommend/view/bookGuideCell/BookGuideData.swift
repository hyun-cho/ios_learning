//
//  BookGuide.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/17.
//

import UIKit

struct BookGuideData {
    let cellIdentifier: String = "BookGuideCell"
    
    private(set) var title: String
    private(set) var description: String
    
    private(set) var remoteURL: String?
    
    init(title: String, description: String, remoteURL: String) {
        self.title = title
        self.description = description
        self.remoteURL = remoteURL
    }
}
