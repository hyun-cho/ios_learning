//
//  BookRecThirdCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit


class BookRecThirdCell: UITableViewCell {
    var bookStore: BookStore?
    
    @IBOutlet var bookCollectionView: UICollectionView!
    @IBOutlet var title: UILabel!
    
    func initBooks(title: String, bookStore: BookStore) {
        self.title.text = title
        self.bookStore = bookStore
        
        bookCollectionView.register(BookCollectionCell.self, forCellWithReuseIdentifier: "BookCollectionCell")
        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
    }
}

extension BookRecThirdCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookStore?.books.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionCell", for: indexPath) as! BookCollectionCell
        
        cell.book = bookStore?.books[indexPath.row]
        print("tteesstt")
        print(collectionView)
        print(cell)
        
        return cell
    }
}


extension BookRecThirdCell: UICollectionViewDelegateFlowLayout {
    //셀크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("tteessttt")
        print(collectionView.frame.width / 3)
        let width = collectionView.frame.width / 3
        return CGSize(width: width, height: width)
    }

    //위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //좌우간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
