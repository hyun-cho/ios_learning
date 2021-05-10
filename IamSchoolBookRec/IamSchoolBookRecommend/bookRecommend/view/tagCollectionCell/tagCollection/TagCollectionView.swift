//
//  TagCollectionView.swift
//  IamSchoolBookRecommend
//
//  Created by NHN on 2021/05/06.
//

import UIKit

class TagCollectionView: UIView {
    @IBOutlet private var tagTitleLabel: UILabel!
    
    @IBOutlet private var tagCollectionView: UICollectionView!
    
    var viewModel :TagCollectionData? {
        didSet {
            tagTitleLabel.text = viewModel?.title ?? ""
            tagCollectionView.dataSource = self
            tagCollectionView.delegate = self
        }
    }
    
    
    
    
    
    static func create(data: TagCollectionData) -> TagCollectionView? {
        let className = String(String(describing: type(of:self)).split(separator: ".")[0])
        let nib = UINib(nibName: className, bundle: Bundle.main)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? TagCollectionView else {
            return nil
        }
        view.viewModel = data
        return view
    }
}

extension TagCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.name.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
extension TagCollectionView: UICollectionViewDelegateFlowLayout {
    
}
