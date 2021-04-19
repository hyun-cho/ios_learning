//
//  BookCollectionCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView! = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    var bookName: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var book: Book? {
        didSet {
            bookName.text = book?.name
            imageView.image = book?.image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(bookName)
        bookName.font = UIFont.systemFont(ofSize: 8)
        
        let constraints = [
            NSLayoutConstraint(item: imageView!, attribute: .height, relatedBy: .equal, toItem: self.contentView, attribute: .height, multiplier: 0.7, constant: 0.0),
            NSLayoutConstraint(item: imageView!, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            
            NSLayoutConstraint(item: imageView!, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .topMargin, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView!, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView!, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imageView!, attribute: .bottom, relatedBy: .equal, toItem: bookName!, attribute: .top, multiplier: 1.0, constant: 5.0),
            
            NSLayoutConstraint(item: bookName!, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: bookName!, attribute: .width, relatedBy: .equal, toItem: imageView!, attribute: .width, multiplier: 0.9, constant: 0.0), 
            NSLayoutConstraint(item: bookName!, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0),
        ]
        constraints.forEach({ $0.isActive = true })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init with coder not implemented error")
    }
}
