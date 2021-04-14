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
    var delegate: UITableViewDelegate?
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
        
        contentView.backgroundColor = .white
        contentView.addSubview(nameLabel)
        contentView.addSubview(serialNumberLabel)
        contentView.addSubview(valueLabel)
        
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        serialNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .topMargin, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: nameLabel, attribute: .bottom, relatedBy: .equal, toItem: serialNumberLabel, attribute: .top, multiplier: 1.0, constant: -10.0),
            NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: serialNumberLabel, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: serialNumberLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: valueLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: valueLabel, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0)
        ]
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

extension ItemCell: UITableViewDelegate {
    
}
