//
//  ImageLoader.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import UIKit

protocol ImageLoader {
    func loadImage(_ imageView: UIImageView, url remoteURL: String)
    func loadImage(_ imageView: UIImageView, url remoteURL: String, completion: @escaping (UIImage) -> Void)
    func loadImage(_ imageView: UIImageView, url remoteURL: String, completion: @escaping (UIImage) -> Void, withCancelToken: String) -> String?
    func cancelImage(cancelToken: String)
}
