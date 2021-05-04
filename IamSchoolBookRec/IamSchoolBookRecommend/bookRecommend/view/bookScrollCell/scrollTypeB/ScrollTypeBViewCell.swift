//
//  ScrollCellTypeB.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import UIKit

class ScrollTypeBViewCell: PagingScrollViewCell {
    @IBOutlet private var bookImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    @IBOutlet private var labelWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var imageViewHeightConstraint: NSLayoutConstraint!
    
    private let spacingBetweenImageAndLabel: CGFloat = 20
    private let nextItemWidth: CGFloat = 63
    private let imageWidth: CGFloat = 108
    private let imageMinHeight: CGFloat = 96
    private let imageMaxHeight: CGFloat = 156
    private let labelWidth: CGFloat = 156

    private let imageLoader: ImageLoader = ImageLoaderKf()
    
    override func updateConstraints() {
        super.updateConstraints()
        updateImageLabelWidthConstraint()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var viewModel: ScrollTypeBViewCellData? {
        didSet {
            guard let remoteURL = viewModel?.remoteURL else {
                return
            }
            imageLoader.loadImage(bookImageView, url: remoteURL) {
                [weak self]
                (image) -> Void in
                self?.updateImageHeightConstraint(size: image.size)
            }
            nameLabel.text = viewModel?.name
            descriptionLabel.text = viewModel?.description
            
            
            updateConstraints()
        }
    }
    private func updateImageLabelWidthConstraint() {
        labelWidthConstraint.constant = labelWidth
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
