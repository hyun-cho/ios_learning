//
//  ScrollCellTypeB.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import UIKit

class ScrollTypeBViewCell: UIPagingScrollViewCell {
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
    
    private var labelWidth: CGFloat? {
        get {
            return UIScreen.main.bounds.width - imageWidth - spacingBetweenImageAndLabel - CGFloat((interItemSpacing ?? 20) * 2) - nextItemWidth
        }
    }

    override func updateConstraints() {
        super.updateConstraints()
        updateImageLabelWidthConstraint()
    }
    
    var viewModel: ScrollTypeBViewCellData? {
        didSet {
            guard let image = viewModel?.image,
                  let name = viewModel?.name,
                  let description = viewModel?.description else {
                return
            }
            bookImageView.image = image
            nameLabel.text = name
            descriptionLabel.text = description
            
            alignWithSuperview = .centerY
            maxSize = CGSize(width: 0, height: imageMaxHeight)
            updateImageHeightConstraint(size: image.size)
            updateConstraints()
        }
    }
    private func updateImageLabelWidthConstraint() {
        if let width = labelWidth {
            labelWidthConstraint.constant = width
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
