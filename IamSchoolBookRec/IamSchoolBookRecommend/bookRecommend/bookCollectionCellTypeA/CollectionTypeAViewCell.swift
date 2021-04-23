//
//  BookCollectionCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit

class CollectionTypeAViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var imageViewHeightConstraint: NSLayoutConstraint!
    
    private final let imageMaxHeight: CGFloat = 137
    private final let imageMinHeight: CGFloat = 67
    private final let imageWidth: CGFloat = 95
    
    var viewModel: CollectionTypeAViewCellData? {
        didSet{
            guard let name = viewModel?.name,
                  let image = viewModel?.image else {
                return
            }
            nameLabel.text = name
            imageView.image = image
            updateImageHeightConstraint(size: image.size)
        }
    }
    
    private func updateImageHeightConstraint(size: CGSize) {
        var newHeight = size.height / size.width * imageWidth
        if newHeight < imageMinHeight {
            newHeight = imageMinHeight
        }
        if newHeight > imageMaxHeight {
            newHeight = imageMaxHeight
        }
        imageViewHeightConstraint.constant = newHeight
    }
}
