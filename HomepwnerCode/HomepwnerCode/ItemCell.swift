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
    var nameLabel: UILabel = {
        let nameLabel = UILabel()
        
        nameLabel.textColor = .black
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        return nameLabel
    }()
    var serialNumberLabel: UILabel = {
        let serialNumberLabel = UILabel()
        
        serialNumberLabel.textColor = .lightGray
        serialNumberLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        return serialNumberLabel
    }()
    var valueLabel: UILabel = {
        let valueLabel = UILabel()
        
        valueLabel.textColor = .black
        valueLabel.font = UIFont.preferredFont(forTextStyle: .body)
        return valueLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(serialNumberLabel)
        self.contentView.addSubview(valueLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        serialNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [nameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
                           nameLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
                           nameLabel.leadingAnchor.constraint(equalTo: serialNumberLabel.leadingAnchor),
                           serialNumberLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
                           valueLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
                           valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)]
        constraints.forEach({ $0.isActive = true })
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateLabels(item: Item) {
        if item.valueInDollars >= 50 {
            self.backgroundColor = .red
        }
        else {
            self.backgroundColor = .green
            
        }
        
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        
        let caption1Font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
        serialNumberLabel.font = caption1Font
    }
}
