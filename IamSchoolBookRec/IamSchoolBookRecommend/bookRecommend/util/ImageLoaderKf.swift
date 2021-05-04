//
//  ImageLoaderKingfisher.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/05/03.
//

import UIKit
import Kingfisher

class ImageLoaderKf: ImageLoader {
    private var taskDictionary: [String: DownloadTask] = [:]
    func loadImage(_ imageView: UIImageView, url remoteURL: String?) {
        guard let remoteURL = remoteURL else {
            return
        }
        let url = URL(string: remoteURL)
        imageView.kf.setImage(with: url)
    }
    func loadImage(_ imageView: UIImageView, url remoteURL: String, completion: @escaping (UIImage) -> Void) -> String {
        let url = URL(string: remoteURL)
        // url: URL?
        taskDictionary[remoteURL] = imageView.kf.setImage(with: url) {
            [weak self]
            (result) in
            self?.taskDictionary.removeValue(forKey: remoteURL)
            switch result {
            case .success(let imageResult):
                completion(imageResult.image)
            case .failure(let error):
                print(error)
            }
        }
        return remoteURL
    }
    
    func cancelImage(remoteURL: String) {
        // dictionary
    }
}
