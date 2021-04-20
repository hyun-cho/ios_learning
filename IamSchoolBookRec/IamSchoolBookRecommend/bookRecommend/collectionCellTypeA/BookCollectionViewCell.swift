//
//  BookCollectionCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var imageViewHeightConstraint: NSLayoutConstraint!
    
    var book: Book? {
        didSet {
            guard let name = book?.name,
                  let image = book?.image else {
                return
            }
            nameLabel.text = name
            imageView.image = image
            
            var newHeight = image.size.height / image.size.width * 95
            if newHeight < 67 {
                newHeight = 67
            }
            if newHeight > 137 {
                newHeight = 137
            }
            imageViewHeightConstraint.constant = newHeight
        }
    }
}
