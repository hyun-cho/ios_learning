//
//  ScrollCellTypeB.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import UIKit

class ScrollTypeBViewCell: UIView {
    @IBOutlet private var bookImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    
    @IBOutlet private var labelWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var imageViewHeightConstraint: NSLayoutConstraint!
    
    private let spacingBetweenImageAndLabel: CGFloat = 20
    private let imageWidth: CGFloat = 108
    private let imageMinHeight: CGFloat = 96
    private let imageMaxHeight: CGFloat = 156
    
    var leadingConstant: CGFloat = 0
    var leadingConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var centerYConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
    private var cellWidth: CGFloat? {
        didSet {
            if let cellwidth = cellWidth {
                labelWidthConstraint.constant = cellwidth - imageWidth - leadingConstant - spacingBetweenImageAndLabel
            }
        }
    }
    var cellHeight: CGFloat {
        get {
            imageMaxHeight
        }
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
            
            updateImageHeightConstraint(size: image.size)
            updateConstraintsIfNeeded()
        }
    }
    
    static func create(bookData: ScrollTypeBViewCellData, cellWidth: CGFloat, leadingConstant: CGFloat) -> ScrollTypeBViewCell? {
        let className = String(String(describing: type(of:self)).split(separator: ".")[0])
        let nib = UINib(nibName: className, bundle: Bundle.main)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? ScrollTypeBViewCell else {
            return nil
        }
        
        view.viewModel = bookData
        view.leadingConstant = leadingConstant
        view.cellWidth = cellWidth
        view.translatesAutoresizingMaskIntoConstraints = false
        view.updateConstraintsIfNeeded()
        return view
    }
    
    func updateData(viewModel: ScrollTypeBViewCellData, index: Int) {
        self.viewModel = viewModel

        leadingConstraint.constant = self.cellWidth! * CGFloat(index)
    }
    
    func updateConstraints(leading: UIView, centerY: UIView, index: Int) {
        self.leadingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: leading, attribute: .leading, multiplier: 1.0, constant: CGFloat(index) * self.cellWidth! + leadingConstant)
        self.centerYConstraint = NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: centerY, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        self.leadingConstraint.isActive = true
        self.centerYConstraint.isActive = true
        self.updateConstraints()
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
