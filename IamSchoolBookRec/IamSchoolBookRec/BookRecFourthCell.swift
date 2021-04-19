//
//  BookRecThirdCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit


class BookRecFourthCell: UITableViewCell {
    
    @IBOutlet var bookGuideImage: UIImageView!
    
    @IBOutlet var bookGuideTitle: UILabel!
    @IBOutlet var bookGuideDescription: UILabel!
    
    func initBookGuide(bookGuide: BookGuide) {
        bookGuideImage.image = bookGuide.image
        
        bookGuideTitle.text = bookGuide.title
        bookGuideDescription.text = bookGuide.description
    }
}
