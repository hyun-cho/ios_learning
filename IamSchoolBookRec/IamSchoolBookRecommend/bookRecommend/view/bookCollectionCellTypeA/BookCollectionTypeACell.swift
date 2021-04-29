//
//  BookRecThirdCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit


class BookCollectionTypeACell: UITableViewCell {
    // delegate 패턴 사용해서 TableViewCell의 크기 동적으로 구현하기
    
    @IBOutlet private var bookCollectionView: UICollectionView!
    @IBOutlet private var titleLabel: UILabel!
    
    private final let cellWidth: CGFloat = 95
    // 상수를 구분
    private final let cellHeight: CGFloat = 165.5
    
    var viewModel: BookCollectionTypeAData? {
        didSet {
            titleLabel.text = viewModel?.title ?? ""
        }
    }
    
    override func prepareForReuse() {
        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
    }
}

extension BookCollectionTypeACell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.collectionViewDatas.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellViewModel = viewModel?[indexPath] else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellIdentifier, for: indexPath) as! CollectionTypeAViewCell
        
        cell.viewModel = cellViewModel
        return cell
    }
}

extension BookCollectionTypeACell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let lineSpacing: CGFloat = 25
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // item의 개수로 구현하기보다 폭을 계산 TODO
        let numberOfItems: CGFloat = CGFloat(viewModel?.collectionViewDatas.count ?? 0)
        let maxItemCountInLine: CGFloat = CGFloat(Int(collectionView.frame.width / cellWidth))
        
        var numberOfItemInLine: CGFloat = CGFloat(Int(collectionView.frame.width / cellWidth))
        
        if maxItemCountInLine > numberOfItems {
            numberOfItemInLine = numberOfItems
        }
        
        return (collectionView.frame.width - cellWidth * numberOfItemInLine) / (numberOfItemInLine - 1)
    }
}
