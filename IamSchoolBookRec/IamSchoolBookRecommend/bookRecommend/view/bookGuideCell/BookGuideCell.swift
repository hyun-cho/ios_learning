//
//  BookRecThirdCell.swift
//  IamSchoolBookRec
//
//  Created by NHN on 2021/04/16.
//

import UIKit


class BookGuideCell: UITableViewCell {
    @IBOutlet var bookGuideImage: UIImageView!
    @IBOutlet var bookGuideTitle: UILabel!
    @IBOutlet var bookGuideDescription: UILabel!
    
    var viewModel: BookGuideData? {
        didSet {
            guard let image = viewModel?.image,
                  let title = viewModel?.title,
                  let description = viewModel?.description else {
                print("book guide init viewModel error")
                return
            }
            bookGuideImage.image = image
            bookGuideTitle.text = title
            bookGuideDescription.text = description
        }
    }
}
