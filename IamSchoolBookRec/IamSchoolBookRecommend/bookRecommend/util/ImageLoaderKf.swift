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
    
    func loadImage(_ imageView: UIImageView, url remoteURL: String) {
        let url = URL(string: remoteURL)
        imageView.kf.setImage(with: url)
    }
    func loadImage(_ imageView: UIImageView, url remoteURL: String, completion: @escaping (UIImage) -> Void) {
        let url = URL(string: remoteURL)
        imageView.kf.setImage(with: url) {
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
    }
    func loadImage(_ imageView: UIImageView, url remoteURL: String, completion: @escaping (UIImage) -> Void, withCancelToken: String) -> String? {
        cancelImage(cancelToken: withCancelToken)
        let url = URL(string: remoteURL)
        let downloadTask = imageView.kf.setImage(with: url) {
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
        guard let token = downloadTask?.cancelToken else {
            return nil
        }
        taskDictionary[String(token)] = downloadTask
        return String(token)
    }
    
    func cancelImage(cancelToken: String) {
        guard let downloadTask = taskDictionary[cancelToken] else {
            return
        }
        downloadTask.cancel()
    }
}
