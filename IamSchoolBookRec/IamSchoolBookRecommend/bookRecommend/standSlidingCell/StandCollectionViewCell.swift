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
    // 셀을 그리기 위한 내부 Model
    struct ViewModel {
        
    }
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var standView: UIView!
    
    @IBOutlet private var coverShadow: UIView!
    
    func updateImage(image: UIImage) {
        self.imageView.image = image
        
        var newHeight = image.size.height / image.size.width * 113
        if newHeight < 79 {
            newHeight = 79
        }
        if newHeight > 163 {
            newHeight = 163
        }
        imageViewHeightConstraint.constant = newHeight
        updateConstraintsIfNeeded()
    }
    
    
    // 스토리보드에서 설정 한 뒤에 항상 불린다.
    override func awakeFromNib() {
        super.awakeFromNib()
        // 시작할때 한번 처리되야하는 것들
        // IB에 추가하면, 컴파일과정에서 에러 확인이 안된다.
        // or 속성 inspector를 추가할 수 있다.
        self.standView.layer.borderWidth = 1.0
        self.standView.layer.borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        self.coverShadow.layer.addBorder([.left], color: UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.06), width: 1.0)
    }
    
    // frame 설정
    override func layoutSubviews() {
        super.layoutSubviews()
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

