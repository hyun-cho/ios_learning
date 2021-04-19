//
//  bookStandImageCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/19.
//

import UIKit

class StandCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var imageViewHeightConstraint: NSLayoutConstraint!
    
    func updateImage(image: UIImage) {
        self.imageView.image = image
    }
}
