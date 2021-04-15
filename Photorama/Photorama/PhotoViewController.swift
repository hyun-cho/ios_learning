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
    let photoDataSource: PhotoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView = {
            [weak self] in
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
            return collectionView
        }()
        
        self.title = "Photorama"
        self.view.addSubview(collectionView)
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        fetchRecentPhotos()
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        self.collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
    }
    
    func fetchRecentPhotos() {
        store.fetchRecentPhotos() {
            (photosResult) -> Void in
            OperationQueue.main.addOperation {
                [weak self] in
                switch photosResult {
                case let .Success(photos):
                    print("succeessfully found \(photos.count) recent photos.")
                    self?.photoDataSource.photos = photos
                case let .Failure(error):
                    print("error fetching recent photos:  \(error)")
                    self?.photoDataSource.photos.removeAll()
                }
                self?.collectionView.reloadData()
                self?.collectionView.reloadSections(IndexSet(integer: 0))
                print("reload data")
            }
        }
    }
    func setConstrains() {
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
    
    deinit {
        print(#file)
        print("deinited")
    }
    
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    //셀크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }

    //위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    //좌우간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photoDataSource = collectionView.dataSource as! PhotoDataSource
        
        let photo = photoDataSource.photos[indexPath.row]
        
        // single rxswift - reactive ()
        // shared singleton
        PhotoStore.shared
            .fetchImageForPhoto(photo: photo) {
            (result) -> Void in
            
            OperationQueue.main.addOperation {
                // 사진의 인덱스패스는 요청의 시작과 끝 사이에 변경 될 수 있다. -> 최근 인덱스패스를 찾는다.
                let photoIndex = photoDataSource.photos.firstIndex(where: { $0 == photo })!
                let photoIndexPath = IndexPath(row: photoIndex, section: 0)
                
                if let cell = collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                    cell.updateWithImage(image: photo.image)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoDataSource = collectionView.dataSource as! PhotoDataSource
        let photo = photoDataSource.photos[indexPath.row]
        
        showPhotoInfoView(photo: photo)
    }
    
    func showPhotoInfoView(photo: Photo) {
        let vc = PhotoInfoViewController()
        vc.photo = photo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


