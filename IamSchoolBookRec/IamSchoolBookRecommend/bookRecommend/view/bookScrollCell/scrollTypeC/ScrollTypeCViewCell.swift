//
//  ScrollTypeCViewCell.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import UIKit
import Kingfisher
class ScrollTypeCViewCell: PagingScrollViewCell {
    @IBOutlet private var bookImageView: UIImageView!
    @IBOutlet private var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var nameLabel: UILabel!
    
    private let imageMinHeight: CGFloat = 96
    private let imageMaxHeight: CGFloat = 156
    private let imageWidth: CGFloat = 106
    
    private let imageLoader: ImageLoader = ImageLoaderKf()
    
    var viewModel: ScrollTypeCViewCellData? {
        didSet {
            imageLoader.loadImage(bookImageView, url: viewModel?.remoteURL) {
                [weak self]
                (image) -> Void in
                self?.updateImageHeightConstraint(size: image.size)
            }
            nameLabel.text = viewModel?.name
            
            updateConstraintsIfNeeded()
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
        updateConstraintsIfNeeded()
    }
    
}
