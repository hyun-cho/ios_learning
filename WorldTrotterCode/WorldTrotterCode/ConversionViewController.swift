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
    
    lazy var textField: UITextField! = {
        let textField: UITextField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.placeholder = "value"
        textField.textColor = .orange
        textField.addTarget(self, action: #selector(self.fahrenheitFieldEditingChanged), for: .editingChanged)
        textField.font = textField.font?.withSize(70)
        return textField
    }()
    lazy var celsiusLabel: UILabel! = {
        let celsiusLabel: UILabel = UILabel()
        celsiusLabel.translatesAutoresizingMaskIntoConstraints = false
        celsiusLabel.text = "???"
        celsiusLabel.textColor = .orange
        celsiusLabel.font = celsiusLabel.font.withSize(70)
        return celsiusLabel
    }()
    
    override func loadView() {
        super.loadView()
        
        let degreesFahrenheitLabel: UILabel! = {
            let degreesFahrenheitLabel: UILabel! = UILabel()
            degreesFahrenheitLabel.translatesAutoresizingMaskIntoConstraints = false
            degreesFahrenheitLabel.text = "degrees Fahrenheit"
            degreesFahrenheitLabel.textColor = .orange
            degreesFahrenheitLabel.font = degreesFahrenheitLabel.font.withSize(36)
            return degreesFahrenheitLabel
        }()
        
        let isReallyLabel: UILabel! = {
            let isReallyLabel: UILabel! = UILabel()
            isReallyLabel.translatesAutoresizingMaskIntoConstraints = false
            isReallyLabel.text = "is really"
            isReallyLabel.font = isReallyLabel.font.withSize(36)
            return isReallyLabel
        }()
        
        let degreesCelsiusLabel: UILabel! = {
            let degreesCelsiusLabel: UILabel! = UILabel()
            degreesCelsiusLabel.translatesAutoresizingMaskIntoConstraints = false
            degreesCelsiusLabel.text = "degrees Celsius"
            degreesCelsiusLabel.textColor = .orange
            degreesCelsiusLabel.font = degreesCelsiusLabel.font.withSize(36)
            return degreesCelsiusLabel
        }()
        
        view.addSubview(textField)
        view.addSubview(celsiusLabel)
        view.addSubview(degreesFahrenheitLabel)
        view.addSubview(isReallyLabel)
        view.addSubview(degreesCelsiusLabel)
        
        
        let textFieldConstraints: [NSLayoutConstraint] = [textField.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                                                          textField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8.0)]
        let degreesFahrenheitConstraints: [NSLayoutConstraint] = [degreesFahrenheitLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                                                                       degreesFahrenheitLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15)]
        let isReallyConstraints: [NSLayoutConstraint] = [isReallyLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                                                         isReallyLabel.topAnchor.constraint(equalTo: degreesFahrenheitLabel.bottomAnchor, constant: 30)]
        let celsiusLabelConstraints: [NSLayoutConstraint] = [celsiusLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                                                             celsiusLabel.topAnchor.constraint(equalTo: isReallyLabel.bottomAnchor, constant: 30)]
        let degreeCelsiusConstraints: [NSLayoutConstraint] = [degreesCelsiusLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                                                              degreesCelsiusLabel.topAnchor.constraint(equalTo: celsiusLabel.bottomAnchor, constant: 15)]
        textFieldConstraints.forEach({ $0.isActive = true })
        degreesFahrenheitConstraints.forEach({ $0.isActive = true })
        isReallyConstraints.forEach({ $0.isActive = true })
        celsiusLabelConstraints.forEach({ $0.isActive = true })
        degreeCelsiusConstraints.forEach({ $0.isActive = true })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        let colorArray: [UIColor] = [UIColor.white, UIColor.lightGray, UIColor.darkGray]
        view.backgroundColor = colorArray.randomElement()
        
        print("ConversionViewController loaded its view, appear")
    }
    

    // add Target을 위해서 꼭 @objc를 사용해야 하는지?
    @objc func fahrenheitFieldEditingChanged(textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = value
        }
        else {
            fahrenheitValue = nil
        }
    }
    
    func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.contains(".")
        let replacementTextHasDecimalSeparator = string.contains(".")
        
        if existingTextHasDecimalSeparator ?? false == true &&
            replacementTextHasDecimalSeparator {
            return false
        }
        
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
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.string(for: value)
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
}
