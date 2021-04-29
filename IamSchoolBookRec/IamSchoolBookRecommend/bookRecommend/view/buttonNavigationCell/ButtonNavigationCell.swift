//
//  buttonNavigationCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/19.
//

import UIKit

// cell -> xib로 변경
class ButtonNavigationCell: UITableViewCell {
    @IBOutlet private var buttonStackView: UIStackView!
    
    var viewModel: ButtonNavigationData? {
        didSet {
            guard let buttonDatas = viewModel?.buttonDatas else {
                print("button navigation viewModel init failed")
                return
            }
            removeAllSubview(from: buttonStackView)
            createNavigationButton(buttonDatas)
        }
    }
    private var buttonEqualWidthConstraints: [NSLayoutConstraint] = [NSLayoutConstraint]()
    
    private func removeAllSubview(from: UIStackView) {
        buttonEqualWidthConstraints.forEach({ $0.isActive = false })
        buttonEqualWidthConstraints.removeAll()
        from.arrangedSubviews.forEach({
            $0.removeFromSuperview()
        })
    }
    
    private func createNavigationButton(_ buttonDatas: [NavigationButtonData]) {
        buttonDatas.forEach({
            guard let button = NavigationButton.create(buttonData: $0) else {
                print("navigation button not created")
                return
            }
            self.buttonStackView.addArrangedSubview(button)
            guard let firstButton = self.buttonStackView.subviews.first else {
                return
            }
            
            let buttonWidthEqualWithFirstButton = NSLayoutConstraint(item: firstButton, attribute: .width, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1.0, constant: 0.0)
            buttonWidthEqualWithFirstButton.isActive = true
            buttonEqualWidthConstraints.append(buttonWidthEqualWithFirstButton)
        })

    }
    
}
