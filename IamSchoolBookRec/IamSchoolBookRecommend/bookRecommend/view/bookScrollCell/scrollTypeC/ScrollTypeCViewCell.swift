//
//  ScrollTypeCViewCell.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import UIKit
class ScrollTypeCViewCell: PagingScrollViewCell {
    @IBOutlet private var bookImageView: UIImageView!
    @IBOutlet private var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var nameLabel: UILabel!
    
    
    
    private let imageMinHeight: CGFloat = 96
    private let imageMaxHeight: CGFloat = 156
    private let imageWidth: CGFloat = 106
    
    var viewModel: ScrollTypeCViewCellData? {
        didSet {
            bookImageView.image = viewModel?.image
            nameLabel.text = viewModel?.name
            
            updateImageHeightConstraint()
            updateConstraintsIfNeeded()
        }
    }
    
    private func updateImageHeightConstraint() {
        guard let size = viewModel?.image?.size else {
            return
        }
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
