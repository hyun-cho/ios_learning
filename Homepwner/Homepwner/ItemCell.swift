//
//  ItemCell.swift
//  Homepwner
//
//  Created by NHN on 2021/04/10.
//

import UIKit

// UITableViewCell 하위 클래스에서, contentView에 하위 뷰들을 추가해 사용자화 한다.
// 셀이 특정할 때에 contentView의 크기를 바꾸기 때문
class ItemCell: UITableViewCell {
    // 하위 뷰에 직접 추가하면, 편집 컨트롤들이 하위 뷰들을 가릴 것이다.
    
    // contentView는 크기를 조절 가능하다.
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    func updateLabels(item: Item) {
        if item.valueInDollars >= 50 {
            contentView.backgroundColor = .red
        }
        else {
            contentView.backgroundColor = .green
        }
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        
        let caption1Font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
        serialNumberLabel.font = caption1Font
    }
}
