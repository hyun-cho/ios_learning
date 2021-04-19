//
//  buttonNavigationCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/19.
//

import UIKit

class ButtonNavigationCell: UITableViewCell, HasTask {
    var task: BookRecommendTask?
    func updateTask(task: BookRecommendTask) {
        self.task = task
    }
    
    @IBOutlet var buttonStackView: UIStackView!
    @IBOutlet var buttons: [UIButton]!
    
    override func updateConstraints() {
        super.updateConstraints()
        
        buttons.forEach({ $0.layer.cornerRadius = 10 })
    }
}
