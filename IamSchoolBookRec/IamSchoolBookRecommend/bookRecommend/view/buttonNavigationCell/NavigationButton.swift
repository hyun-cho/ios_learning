//
//  NavigationButton.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/21.
//

import UIKit

class NavigationButton: UIView {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    static func create(buttonData: NavigationButtonData) -> UIView? {
        let className = String(String(describing: type(of:self)).split(separator: ".")[0])
        let nib = UINib(nibName: className, bundle: Bundle.main)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? NavigationButton else {
            return nil
        }
        view.layer.cornerRadius = 6
        view.titleLabel.text = buttonData.title
        view.iconImageView.image = buttonData.image
        return view
    }
}
