//
//  PhotoViewController.swift
//  Photorama
//
//  Created by NHN on 2021/04/13.
//

import UIKit


class PhotoViewController : UIViewController {
    // 이미지 뷰 대신, 컬렉션 뷰를 사용
    var collectionView: UICollectionView!
    
    var store: PhotoStore = PhotoStore()
    let photoDataSource = PhotoDataSource()
    var photoDelegateFlowLayout = PhotoDelegateFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchRecentPhotos() {
            (photosResult) -> Void in
            OperationQueue.main.addOperation {
                switch photosResult {
                case let .Success(photos):
                    print("succeessfully found \(photos.count) recent photos.")
                    self.photoDataSource.photos = photos
                case let .Failure(error):
                    self.photoDataSource.photos.removeAll()
                    print("error fetching recent photos:  \(error)")
                }
                self.collectionView.reloadData()
                self.collectionView.reloadSections(IndexSet(integer: 0))
                print("reload data")
            }
        }
        
        collectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
            return collectionView
        }()
        self.view.addSubview(collectionView)
        collectionView.dataSource = photoDataSource
        collectionView.delegate = photoDelegateFlowLayout
        self.collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    
        collectionView.backgroundColor = .white
        self.title = "Photorama"
        
        
        
        let constraints = [
            NSLayoutConstraint(item: collectionView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: collectionView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: collectionView!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: collectionView!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        ]
        constraints.forEach({ $0.isActive = true })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

