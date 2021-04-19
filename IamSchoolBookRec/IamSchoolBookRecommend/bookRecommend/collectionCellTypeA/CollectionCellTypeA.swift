//
//  BookRecThirdCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit


class CollectionCellTypeA: UITableViewCell, HasTask {
    var task: BookRecommendTask?
    var books: [Book] {
        get {
            guard let books = task?.dataSource as? [Book] else {
                print("books is not exist in StandSlidingCell")
                return []
            }
            return books
        }
    }

    func updateTask(task: BookRecommendTask) {
        self.task = task
        
        bookCollectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCollectionViewCell")
        bookCollectionView.dataSource = self
        bookCollectionView.delegate = self
    }
    
    @IBOutlet var bookCollectionView: UICollectionView!
    @IBOutlet var title: UILabel!
    
}

extension CollectionCellTypeA: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        
        cell.book = books[indexPath.row]
        print("tteesstt")
        print(collectionView)
        print(cell)
        
        return cell
    }
}


extension CollectionCellTypeA: UICollectionViewDelegateFlowLayout {
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
