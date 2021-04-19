//
//  BookFirstIntroPageCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/15.
//

import UIKit

class BookRecFirstCell: UITableViewCell {
    var bookStore: BookStore!
    
    @IBOutlet var bookStandScollView: UIScrollView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var bookPageControl: UIPageControl!
    
    
    func initBooks(bookStore: BookStore) {
        self.bookStore = bookStore
        
        for index in 0..<bookStore.books.count {
            let bookStandStackView = UIBookStandStackView()
            
            let book = bookStore.books[index]
            bookStandStackView.book = book
            bookStandStackView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: self.bounds.height / 2)
            
            let constantOriginX = UIScreen.main.bounds.width / 4
            bookStandStackView.frame.origin.x = constantOriginX +  bookStandStackView.frame.width * CGFloat(index)
            bookStandScollView.addSubview(bookStandStackView)
            
            let constrains = [
                NSLayoutConstraint(item:bookStandStackView, attribute: .top, relatedBy: .equal, toItem: bookStandScollView.contentLayoutGuide, attribute: .top, multiplier: 1.0, constant: 20.0),
                NSLayoutConstraint(item: bookStandScollView.frameLayoutGuide, attribute: .width, relatedBy: .equal, toItem: bookStandStackView, attribute: .width, multiplier: 0.5, constant: 0.0),
                NSLayoutConstraint(item: bookStandScollView.frameLayoutGuide, attribute: .height, relatedBy: .equal, toItem: bookStandStackView, attribute: .height, multiplier: 1.0, constant: 0.0)
            ]
            constrains.forEach({ $0.isActive = true })
        }
   
        
        bookStandScollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width / 2 * CGFloat(bookStore.books.count + 1) ,
            height: bookStandScollView.frame.size.height
        )
        
        updatePageControl(index: 0)
        bookPageControl.numberOfPages = bookStore.books.count
        bookPageControl.isUserInteractionEnabled = false
    
    }
    
    func updatePageControl(index: Int) {
        bookPageControl.currentPage = index
        nameLabel?.text = bookStore.books[bookPageControl.currentPage].name
        descriptionLabel?.text = bookStore.books[bookPageControl.currentPage].description
    }
    
}

extension BookRecFirstCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.contentOffset.x / (UIScreen.main.bounds.width / 2)
        
        updatePageControl(index: Int(round(width)))   
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset;
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        bookStandScollView.setContentOffset(CGPoint(x: (UIScreen.main.bounds.width / 2) * CGFloat(bookPageControl.currentPage), y: 0), animated: true)
    }
}

class UIBookStandStackView: UIStackView {
    var book: Book? {
        didSet {
            imageView.image = book?.image
        }
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var bookStandBlank: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 0, height: -5)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .vertical
        self.alignment = .center
        self.addArrangedSubview(imageView)
        self.addArrangedSubview(bookStandBlank)
        
        let constraints = [
            NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.5, constant: 0.0),
            NSLayoutConstraint(item: bookStandBlank, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.7, constant: 0.0),
            NSLayoutConstraint(item: bookStandBlank, attribute: .height, relatedBy: .equal, toItem: imageView, attribute: .height, multiplier: 0.1, constant: 0.0),
        ]
        constraints.forEach({ $0.isActive = true })
    }
    required init(coder: NSCoder) {
        fatalError("UIBookStandStackView init with code not implemented")
    }
}
