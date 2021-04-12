//
//  DetailViewController.swift
//  Homepwner
//
//  Created by NHN on 2021/04/10.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateCreated: UILabel!
    
    var item: Item!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: item.valueInDollars as NSNumber)
        dateCreated.text = dateFormatter.string(from: item.dateCreated as Date)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialField.text
        
        if let valueText = valueField.text,
           let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        }
        else {
            item.valueInDollars = 0
        }
    }
}
