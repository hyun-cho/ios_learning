//
//  ScrapBookCell.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import UIKit

class BookScrapCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var bookImageView: UIImageView!
    @IBOutlet var bookName: UILabel!
    @IBOutlet var bookDescription: UILabel!
    var viewModel: BookScrapData? {
        didSet {
            titleLabel.text = viewModel?.title ?? ""
            bookName.text = viewModel?.book.name ?? ""
            bookDescription.text = viewModel?.book.description ?? ""
            guard let image = viewModel?.book.image else {
                return
            }
            bookImageView.image = image
        }
    }
}
