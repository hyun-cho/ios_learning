//
//  BookScrollCell.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import UIKit
class BookScrollCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bookScrollView: UIPagingScrollView!
    
    var viewModel: BookScrollData? {
        didSet {
            print("pagingscrollview viewmodel updated")
            bookScrollView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        print("scrollCell awake from nib")
        bookScrollView.layoutDelegate = self
        bookScrollView.dataSource = self
        bookScrollView.register(UINib(nibName: "ScrollTypeBViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ScrollTypeBViewCell")
    }
    
    override func prepareForReuse() {
        print("prepare")
        print(self.frame.size)
    }
}

extension BookScrollCell: UIPagingScrollDataSource {
    func scrollViewNumberOfItems(_ pagingScrollView: UIPagingScrollView) -> Int {
        return viewModel?.scrollViewDatas.count ?? 0
    }
    
    func scrollView(_ pagingScrollView: UIPagingScrollView, cellForItemAt index: Int) -> UIPagingScrollViewCell {
        guard let dataType = viewModel?[index] else {
            return UIPagingScrollViewCell()
        }
        switch dataType {
        case .typeB(let scrollTypeBViewCellData):
            guard let cell = pagingScrollView.dequeueReusableCell(withIdentifier: scrollTypeBViewCellData.cellIdentifier, for: index) as? ScrollTypeBViewCell else {
                return UIPagingScrollViewCell()
            }
            cell.interItemSpacing = pagingScrollView.layoutDelegate?.interItemSpacing
            cell.viewModel = scrollTypeBViewCellData
            return cell
        case .typeC(let scrollTypeCViewCellData):
            print(scrollTypeCViewCellData)
            return UIPagingScrollViewCell()
        }
    }
}

extension BookScrollCell: UIPagingScrollViewLayoutDelegate {
    // size fix
    
    var scrollDirection: ScrollDirection {
        return .horizon
    }
    
    var interItemSpacing: CGFloat {
        return titleLabel.frame.origin.x
    }
    
    var scrollViewContentInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: titleLabel.frame.origin.x, bottom: 0, right: titleLabel.frame.origin.x)
    }
}
