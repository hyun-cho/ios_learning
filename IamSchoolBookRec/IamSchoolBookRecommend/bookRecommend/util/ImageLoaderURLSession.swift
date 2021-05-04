//
//  ImageLoaderDefault.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/05/03.
//

import UIKit

class ImageLoaderURLSession: ImageLoader {
    func loadImage(_ imageView: UIImageView, url remoteURL: String) {
        let url = URL(string: remoteURL)
        do {
            let data = try Data(contentsOf: url!)
            guard let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                imageView.image = image
            }
        } catch {
            print("book image load error")
        }
    }
    func loadImage(_ imageView: UIImageView, url remoteURL: String, completion: @escaping (UIImage) -> Void) {
        let url = URL(string: remoteURL)
        do {
            let data = try Data(contentsOf: url!)
            guard let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                imageView.image = image
            }
            completion(image)
        } catch {
            print("book image load error")
        }
    }
    
    func loadImage(_ imageView: UIImageView, url remoteURL: String, completion: @escaping (UIImage) -> Void, withCancelToken: String) -> String? {
        // note implemented
        return nil
    }
    func cancelImage(cancelToken: String) {
        // not implemented
    }
}
