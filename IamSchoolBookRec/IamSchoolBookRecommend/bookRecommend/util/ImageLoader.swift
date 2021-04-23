//
//  ImageLoader.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import UIKit

protocol ImageLoader {
}
extension ImageLoader {
    func loadImage(_ remoteURL: String, completion: (UIImage) -> Void) -> Void {
        let url = URL(string: remoteURL)
        do {
            let data = try Data(contentsOf: url!)
            guard let image = UIImage(data: data) else {
                return
            }
            completion(image)
        } catch {
            print("book image load error")
        }
    }
}
