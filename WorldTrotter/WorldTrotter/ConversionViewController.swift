//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by NHN on 2021/04/07.
//

import Foundation
import UIKit

// 델리게이트 프로토콜을 사용해 사용한다.(Delegate가 붙여진 프로토콜 붙인다.)
class ConversionViewController: UIViewController, UITextFieldDelegate {
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
    
    // 사용자가 텍스트 필드를 누르는 시점을 알고자한다면 -> textFieldDidBeginEditing(_:)
    // 입력 요청을 보고자 한다면 -> textField(_:shouldChangeCharactersIn:replacementString:) -> Bool
    // UITextFieldDelegate에 들어가보면 모든 메서드가 optional로 설정되어 있다.
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        // UITextField.text -> String?
        // print("current text: \(textField.text!)")
        // print("replacement text : \(string)")
        
        // 두번 째 소수점을 거부하는 delegation
        // rangeOfString -> contains
        let existingTextHasDecimalSeparator = textField.text?.contains(".")
        let replacementTextHasDecimalSeparator = string.contains(".")
        
        if existingTextHasDecimalSeparator ?? false == true &&
            replacementTextHasDecimalSeparator {
            return false
        }
        
        // lowercase, uppercase 캐릭터셋 확인 -> 더 좋은 방법이 있지 않을까요?
        var alphaCharacterSet = CharacterSet(charactersIn: "a"..."z")
        alphaCharacterSet.insert(charactersIn: "A"..."Z")
        let replacementTextHasCharacterValue = string.rangeOfCharacter(from: alphaCharacterSet)
        
        if replacementTextHasCharacterValue != nil{
            return false
        }
        
        return true
        
    }

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
    
}
