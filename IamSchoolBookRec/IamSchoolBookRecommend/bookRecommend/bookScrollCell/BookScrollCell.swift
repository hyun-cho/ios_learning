//
//  BookScrollCell.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/04/22.
//

import UIKit
class BookScrollCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bookScrollView: PagingScrollView!
    
    private var layoutMarginLeft: CGFloat {
        titleLabel.frame.origin.x
    }
    
    var viewModel: BookScrollData? {
        didSet {
            print("pagingscrollview viewmodel updated")
            titleLabel.text = viewModel?.title
            bookScrollView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        print("scrollCell awake from nib")
        bookScrollView.layoutDelegate = self
        bookScrollView.dataSource = self
        bookScrollView.directionDelegate = self
            
        bookScrollView.register(UINib(nibName: "ScrollTypeBViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ScrollTypeBViewCell")
        bookScrollView.register(UINib(nibName: "ScrollTypeCViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "ScrollTypeCViewCell")
    }
    
}

extension BookScrollCell: PagingScrollDataSource {
    func pagingScrollView(_ pagingScrollView: PagingScrollView, numberOfItems: Int) -> Int {
        return viewModel?.scrollViewDatas.count ?? 0
    }
    
    func pagingScrollView(_ pagingScrollView: PagingScrollView, cellForItemAt index: Int) -> PagingScrollViewCell {
        guard let dataType = viewModel?[index] else {
            return PagingScrollViewCell()
        }
        switch dataType {
        case .typeB(let scrollTypeBViewCellData):
            guard let cell = pagingScrollView.dequeueReusableCell(withIdentifier: scrollTypeBViewCellData.cellIdentifier, for: index) as? ScrollTypeBViewCell else {
                return PagingScrollViewCell()
            }
            cell.alignWith = .centerY
            cell.viewModel = scrollTypeBViewCellData
            return cell
        case .typeC(let scrollTypeCViewCellData):
            guard let cell = pagingScrollView.dequeueReusableCell(withIdentifier: scrollTypeCViewCellData.cellIdentifier, for: index) as? ScrollTypeCViewCell else {
                return PagingScrollViewCell()
            }
            cell.alignWith = .top
            cell.viewModel = scrollTypeCViewCellData
            return cell
        }
    }
}

extension BookScrollCell: PagingScrollViewLayoutDelegate, PagingScrollDirectionHorizonalDelegate {
    func pagingScrollView(_ pagingScrollView: PagingScrollView, cellSize: CGSize?, index forIndex: Int) -> CGSize {
        guard let dataType = viewModel?[forIndex] else {
            return CGSize(width: 0, height: 0)
        }
        switch dataType {
        case .typeB(_):
            return CGSize(width: 300, height: 162)
        case .typeC(_):
            return CGSize(width: 106, height: 188)
        }
        
    }
    
    func pagingScrollView(_ pagingScrollView: PagingScrollView, interItemSpacing: CGFloat) -> CGFloat {
        return layoutMarginLeft
    }
    
    func pagingScrollView(_ pagingScrollView: PagingScrollView, contentInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: layoutMarginLeft, bottom: 0, right: layoutMarginLeft)
    }
}
