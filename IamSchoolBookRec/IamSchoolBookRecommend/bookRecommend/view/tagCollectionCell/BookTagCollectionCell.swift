//
//  BookTagCollectionCell.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/05/06.
//

import UIKit


class BookTagCollectionCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!
    var viewModel: BookTagCollectionData? {
        didSet {
            titleLabel.text = viewModel?.title ?? ""
            viewModel?.tags.forEach({
                [weak self]
                (tagCollectionData) -> Void in
                guard let tagCollectionView = TagCollectionView.create(data: tagCollectionData) else {
                    return
                }
                self?.contentView.addSubview(tagCollectionView)
            })
        }
    }
    
    
    
}
