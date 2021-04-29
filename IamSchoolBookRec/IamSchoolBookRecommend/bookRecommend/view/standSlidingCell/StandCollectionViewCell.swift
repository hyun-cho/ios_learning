//
//  bookStandImageCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/19.
//

import UIKit

// StandCollectionViewCell.ViewModel()
// ViewCell의 Model naming을 명확하게 (폴더링? 네이밍? 이너클래스 ...)
class StandCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var bookStand: UIView!
    @IBOutlet private var bookBorder: UIView!
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var imageHeightConstraint: NSLayoutConstraint!
    
    private final let imageMinHeight: CGFloat = 79
    private final let imageMaxHeight: CGFloat = 163
    private final let imageWidth: CGFloat = 113
    private final let bookMarkColor: UIColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.06)
    
    var viewModel: StandCollectionViewCellData? {
        didSet {
            guard let image = viewModel?.image else {
                return
            }
            self.imageView.image = image
            updateImageHeight(size: image.size)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // bitmap 추가시 삭제 될 요소
        self.bookStand.layer.borderWidth = 1.0
        self.bookStand.layer.borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        
        self.bookBorder.layer.addBorder([.left], color: bookMarkColor, width: 1.0)
    }
    
    private func updateImageHeight(size: CGSize) {
        var newHeight = size.height / size.width * imageWidth
        
        if newHeight < imageMinHeight {
            newHeight = imageMinHeight
        }
        if newHeight > imageMaxHeight {
            newHeight = imageMaxHeight
        }
        imageHeightConstraint.constant = newHeight
        updateConstraintsIfNeeded()
    }
}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}

