//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by NHN on 2021/04/13.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    var imageView: UIImageView!
    
    weak var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        imageView = UIImageView()
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        let constraints = [
            NSLayoutConstraint(item: imageView!, attribute: .width, relatedBy: .lessThanOrEqual, toItem: view, attribute: .width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView!, attribute: .height, relatedBy: .lessThanOrEqual, toItem: view, attribute: .height, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        ]
        constraints.forEach({ $0.isActive = true })
        
        PhotoStore.shared.fetchImageForPhoto(photo: photo, completion: {
            (result) -> Void in
            switch result {
            case let .Success(image):
                OperationQueue.main.addOperation {
                    self.imageView.image = image
                }
            case let .Failure(error):
                print("error fetching image for photo: \(error)")
            }
            
        })
    }
    
    deinit {
        print(#file)
        print("deinited")
    }
}
