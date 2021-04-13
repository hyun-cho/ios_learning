//
//  PhotoDelegateFlowLayout.swift
//  Photorama
//
//  Created by NHN on 2021/04/13.
//

import UIKit

class PhotoDelegateFlowLayout: NSObject, UICollectionViewDelegateFlowLayout {
    var viewController: PhotoViewController?
    init(_ viewController: PhotoViewController) {
        self.viewController = viewController
    }
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
        
        PhotoStore.single.fetchImageForPhoto(photo: photo) {
            (result) -> Void in
            
            OperationQueue.main.addOperation {
                // 사진의 인덱스패스는 요청의 시작과 끝 사이에 변경 될 수 있다. -> 최근 인덱스패스를 찾는다.
                let photoIndex = photoDataSource.photos.firstIndex(where: { $0 == photo })!
                let photoIndexPath = IndexPath(row: photoIndex, section: 0)
                
                if let cell = collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                    cell.updateWithImage(image: photo.image)
                    cell.delegate = self
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoDataSource = collectionView.dataSource as! PhotoDataSource
        
        let photo = photoDataSource.photos[indexPath.row]
        
        let vc = PhotoInfoViewController()
        vc.photo = photo
        pushNavigation(vc)
        
    }
    
    func pushNavigation(_ vc: UIViewController) {
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
