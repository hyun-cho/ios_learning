//
//  BookRecThirdCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit


class BookGuideCell: UITableViewCell, HasTask {
    var task: BookRecommendTask?
    func updateTask(task: BookRecommendTask) {
        self.task = task
    }
    
    @IBOutlet var bookGuideImage: UIImageView!
    
    @IBOutlet var bookGuideTitle: UILabel!
    @IBOutlet var bookGuideDescription: UILabel!
    
    func initBookGuide(bookGuide: BookGuide) {
        bookGuideImage.image = bookGuide.image
        
        bookGuideTitle.text = bookGuide.title
        bookGuideDescription.text = bookGuide.description
    }
}
