//
//  BookFirstIntroPageCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/15.
//

import UIKit

class StandSlidingCell: UITableViewCell, HasTask {
    // 상수 정의 하기
    // Cell에 데이터가 필요할 때, 해당
    var task: BookRecommendTask?
    var bookDetails: [BookDetail] {
        get {
            guard let bookDetails = task?.dataSource as? [BookDetail] else {
//                print("bookDetail is not exist in StandSlidingCell")
                return []
            }
            return bookDetails
        }
    }
    
    var spacing: CGFloat?
    
    func updateTask(task: BookRecommendTask) {
        self.task = task
        
        updatePageControl(index: 0)
        bookPageControl.numberOfPages = bookDetails.count
        bookPageControl.isUserInteractionEnabled = false
    }
    
    // constarint가 갱신될 때마다 호출
    override func updateConstraints() {
        super.updateConstraints()
        
        // **한번만 호출되면 되는 구문** awakeFromNib
        bookStandCollectionView.delegate = self
        bookStandCollectionView.dataSource = self
    }
    
    @IBOutlet private var bookStandCollectionView: UICollectionView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var bookPageControl: UIPageControl!
    
    // view, superview / -> screen의 bound에는 직접적으로 접근 x
    // TODO
    // frame, autolayout 기반 함수 호출 순서 개념 알아보기
    // layoutSubviews -> frame 정적 크기 위주   화면 크기 변경 시 호출되서 새로 구현
    // updateConstraints -> constraints.    auto layout 기준으로 자동 정렬
    // auto layout의 Frame 크기를 가져갈 때 -> 설정 직후 가져가면, frame의 크기가 정확하지 않다.
    
    fileprivate func updatePageControl(index: Int) {
        bookPageControl.currentPage = index
        nameLabel.text = bookDetails[bookPageControl.currentPage].name
        descriptionLabel.text = bookDetails[bookPageControl.currentPage].description
    }
}

extension StandSlidingCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StandCollectionViewCell", for: indexPath) as? StandCollectionViewCell else {
//            print("cell creating in StandCollectionViewCell failed")
            return UICollectionViewCell()
        }
        
        guard let image = bookDetails[indexPath.row].image else {
//            print("fetch image from book Detail failed")
//            print(bookDetails[indexPath.row].image)
            return cell
        }
        cell.updateImage(image: image)
        cell.backgroundColor = .yellow
        
        return cell
    }
}

extension StandSlidingCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 186, height: 176)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let spacing = (collectionView.frame.width - 186 - 54 - 54) / 2
//        return UIEdgeInsets(top: 0, left: collectionView.frame.width / 4, bottom: 0, right: collectionView.frame.width / 4 + spacing * (CGFloat(bookPageControl.numberOfPages) - 1))
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let spacing = (collectionView.frame.width - 186 - 54 - 54) / 2
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }

}

extension StandSlidingCell: UIScrollViewDelegate {
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        targetContentOffset.pointee = scrollView.contentOffset;
//    }
//    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        let spacing = (scrollView.frame.width - 186 - 54 - 54) / 2 + 186
//        let pageIndex = Int(round(scrollView.contentOffset.x / spacing))
////        print(scrollView.contentOffset.x)
////        print(scrollView.contentSize)
////        print(spacing)
////        print(CGFloat(bookPageControl.currentPage) * spacing)
//        updatePageControl(index: pageIndex)
//        scrollView.setContentOffset(CGPoint(x: CGFloat(bookPageControl.currentPage) * spacing, y: 0.0), animated: true)
//    }
}
