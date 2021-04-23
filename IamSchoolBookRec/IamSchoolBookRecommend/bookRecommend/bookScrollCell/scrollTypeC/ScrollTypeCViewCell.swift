//
//  ScrollTypeCViewCell.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import UIKit
class ScrollTypeCViewCell: UIView {
    @IBOutlet private var bookImageView: UIImageView!
    @IBOutlet private var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var nameLabel: UILabel!
    
    var leadingConstraint: NSLayoutConstraint?
    var centerYConstraint: NSLayoutConstraint?
    
    private let imageMinHeight: CGFloat = 96
    private let imageMaxHeight: CGFloat = 156
    private let imageWidth: CGFloat = 106
    
    var leadingConstant: CGFloat = 0
    var cellWidth: CGFloat?
    var cellHeight: CGFloat {
        get {
            imageMaxHeight + 28.5
        }
    }
    
    var viewModel: ScrollTypeCViewCellData? {
        didSet {
            guard let image = viewModel?.image,
                  let name = viewModel?.name else {
                return
            }
            bookImageView.image = image
            nameLabel.text = name
            updateImageHeightConstraint(size: image.size)
            updateConstraintsIfNeeded()
        }
    }
    
    static func create(bookData: ScrollTypeCViewCellData, cellWidth: CGFloat, leadingConstant: CGFloat) -> ScrollTypeCViewCell? {
        let className = String(String(describing: type(of:self)).split(separator: ".")[0])
        let nib = UINib(nibName: className, bundle: Bundle.main)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? ScrollTypeCViewCell else {
            return nil
        }
        
        view.viewModel = bookData
        view.leadingConstant = leadingConstant
        view.cellWidth = cellWidth
        view.translatesAutoresizingMaskIntoConstraints = false
        view.updateConstraintsIfNeeded()
        return view
    }
    
    func updateData(viewModel: ScrollTypeCViewCellData, index: Int) {
        self.viewModel = viewModel
        guard let leadingConstraint = self.leadingConstraint else {
            return
        }
        leadingConstraint.constant = self.cellWidth! * CGFloat(index)
    }

    
    func updateConstraints(leading: UIView, bottom: UIView, index: Int) {
        self.leadingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: leading, attribute: .leading, multiplier: 1.0, constant: CGFloat(index) * (self.cellWidth! + leadingConstant) + leadingConstant)
        self.centerYConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: bottom, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        self.leadingConstraint!.isActive = true
        self.centerYConstraint!.isActive = true
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
