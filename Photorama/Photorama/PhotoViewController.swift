//
//  PhotoViewController.swift
//  Photorama
//
//  Created by NHN on 2021/04/13.
//

import UIKit


class PhotoViewController : UIViewController {
    var imageView: UIImageView = UIImageView()
    
    var store: PhotoStore = PhotoStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchRecentPhotos() {
            (photosResult) -> Void in
            switch photosResult {
            case let .Success(photos):
                print("Successfully found \(photos.count) recent photos")
                
                if let firstPhoto = photos.first {
                    self.store.fetchImageForPhoto(photo: firstPhoto, completion: {
                        (imageResult) -> Void in
                        
                        switch imageResult {
                        case let .Success(image):
                            // 메인 스레드에서 돌고 있지 않기 때문에, 화면에 나타나지 않는다.
//                            self.imageView.image = image
                            OperationQueue.main.addOperation {
                                self.imageView.image = image
                                print("image load complete")
                            }
                        case let .Failure(error):
                            print("Error downloading image: \(error)")
                        }
                    })
                }
               
            case let .Failure(error):
                print("Error fetching recent photos: \(error)")
            }
        }
        
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFill
        self.title = "Photorama"
        
        let constraints = [
            NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        ]
        constraints.forEach({ $0.isActive = true })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
