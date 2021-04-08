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
    // 화면 초기화를 위한 설정
    // viewDidLoad는 lazy하게 한번 초기화하고 더 이상 초기화 하지 않는다.
    // viewWillAppear(_:)는 뷰 컨트롤러가 나타날 때 마다 호출된다.
    override func viewDidLoad() {
        // super의 viewDidLoad()를 항상 호출
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view")
    }
    
    // 컨트롤러 로드 시 마다 랜덤하게 배경화면을 바꾸는 코드
    override func viewWillAppear(_ animated: Bool) {
        // super의 viewDidLoad()를 항상 호출
        super.viewWillAppear(false)
        
        let colorArray: [UIColor] = [UIColor.white, UIColor.blue, UIColor.black, UIColor.red]
        view.backgroundColor = colorArray.randomElement()
        
        print("ConversionViewController loaded its view")
    }
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    
    @IBAction func randomeButton(_ sender: UIButton) {
    }
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        // Double 타입 캐스팅이 되는지 확인, nil 검사
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = value
        }
        else {
            fahrenheitValue = nil
        }
    }
    
    // AnyObject 대신에 event 원형을 받을 수 있다.
    // 대부분 원형으로 받지만, 함수의 재사용을 위해서 Any, AnyObject ...
    // ex) btn 경우 > 
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    // 델리게이트 패턴을 사용 - 직접 할 수 없는 일을 -> 외부에서 처리 할 필요가 있을 때
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
        
        // lowercase, uppercase 캐릭터셋 확인 -> 더 좋은 방법이 있지 않을까요? -> 정규식
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
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            // os 안에 있는 프레임워크도, 아직 swift로 전환이 전부 이루어지지 않았다.
            celsiusLabel.text = numberFormatter.string(for: value)
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
}
