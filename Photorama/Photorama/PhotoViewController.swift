//
//  PhotoViewController.swift
//  Photorama
//
//  Created by NHN on 2021/04/13.
//

import UIKit


class PhotoViewController : UIViewController {
    var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var store: PhotoStore = PhotoStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchRecentPhotos() {
            (photosResult) -> Void in
            switch photosResult {
            case let .Success(photos):
                print("Successfully found \(photos.count) recent photos")
            case let .Failure(error):
                print("Error fetching recent photos: \(error)")
        }
        
        super.view.addSubview(imageView)
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFill
        self.title = "Photorama"
        
        let constraints = [
            NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        ]
        constraints.forEach({ $0.isActive = true })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
