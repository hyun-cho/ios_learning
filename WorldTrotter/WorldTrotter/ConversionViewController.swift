//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by NHN on 2021/04/07.
//

import Foundation
import UIKit

class ConversionViewController: UIViewController {
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * ( 5 / 9 )
        }
        else {
            return nil
        }
    }
    
    // 숫자 포맷 지정자
    // NSNumberFormatter -> NumberFormatter
    // .DecimalStyle -> .decimal
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            // 책과 내용이 많이 다릅니다 ㅜㅜ
            // celsiusLabel.text = numberFormatter.stringFromNumber(value)
            celsiusLabel.text = numberFormatter.string(from: NSNumber(floatLiteral: value))
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        
        // if let text = textField.text where !text.isEmpty {
        // Error??? : Expected ',' joining parts of a multi-clause condition
        /*
        if let text = textField.text ,!text.isEmpty {
            celsiusLabel.text = text
        }
        else {
            celsiusLabel.text = "???"
        }
         */
        
        // Double 타입 캐스팅이 되는지 확인, nil 검사
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = value
        }
        else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
}
