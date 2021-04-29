//
//  BookFirstIntroPageCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/15.
//

import UIKit

class StandSlidingCell: UITableViewCell{
    
    @IBOutlet private var standCollectionView: UICollectionView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var bookPageControl: UIPageControl!
    
    private final let centerCellWidth: CGFloat = 186
    private final let cellHeight: CGFloat = 176
    private final let sideCellWidth: CGFloat = 54
    
    var viewModel: StandSlidingData? {
        didSet {
            bookPageControl.numberOfPages = viewModel?.standSlidingDatas.count ?? 1
            updatePageControl(index: 0)
        }
    }
    
    override func awakeFromNib() {
        bookPageControl.isUserInteractionEnabled = false
        standCollectionView.delegate = self
        standCollectionView.dataSource = self
    }
    
    fileprivate func updatePageControl(index: Int) {
        bookPageControl.currentPage = index
        if index >= bookPageControl.numberOfPages {
            bookPageControl.numberOfPages = bookPageControl.numberOfPages - 1
        }
        else if index < 0 {
            bookPageControl.numberOfPages = 0
        }
        
        nameLabel.text = viewModel?[bookPageControl.currentPage]?.name ?? ""
        descriptionLabel.text = viewModel?[bookPageControl.currentPage]?.description ?? ""
    }
}

extension StandSlidingCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.standSlidingDatas.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StandCollectionViewCell", for: indexPath) as? StandCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        // cell에 필요한 데이터가 image 하나
        cell.viewModel = self.viewModel?[indexPath.row]
        
        return cell
    }
}

extension StandSlidingCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: centerCellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // 기기의 특성에 따라 변경 width - cell /2
        let xInset = (collectionView.frame.width - centerCellWidth) / 2
        return UIEdgeInsets(top: 0, left: xInset, bottom: 0, right: xInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let spaceBetweenCells = (collectionView.frame.width - centerCellWidth - sideCellWidth * 2) / 2
        return spaceBetweenCells
    }
}

extension StandSlidingCell: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset;
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let spaceBetweenCellCenterX = (scrollView.frame.width - centerCellWidth - sideCellWidth * 2) / 2 + centerCellWidth
        let startOffsetX = CGFloat(bookPageControl.currentPage) * spaceBetweenCellCenterX
        let moveOffsetX = scrollView.contentOffset.x - startOffsetX
        var pageIndex = bookPageControl.currentPage
        if moveOffsetX >= 10 {
            pageIndex += 1
        }
        else if moveOffsetX < -10 {
            pageIndex -= 1
        }
        updatePageControl(index: pageIndex)
        scrollView.setContentOffset(CGPoint(x: CGFloat(bookPageControl.currentPage) * spaceBetweenCellCenterX, y: 0.0), animated: true)
    }
}
