//
//  Photo.swift
//  Photorama
//
//  Created by NHN on 2021/04/13.
//

import Foundation

class Photo {
    let title: String
    let photoID: String
    let remoteURL: URL
    let dateTaken: Date
    
    init(title: String, photoID: String, remoteURL: URL, dateTaken: Date) {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
}
