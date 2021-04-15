//
//  BookFirstIntroPageCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/15.
//

import UIKit

class BookFirstIntroPageCell: UITableViewCell {
    @IBOutlet var bookImageView: UIImageView!
    @IBOutlet var bottomShadowLabel: UILabel!
    
    @IBOutlet var bookNameLabel: UILabel!
    @IBOutlet var bookDescLabel: UILabel!
    
    @IBOutlet var bookPageControl: UIPageControl!
    
    func load() {
        bookNameLabel.text = "book name"
        bookDescLabel.text = "book description"
    }
}
