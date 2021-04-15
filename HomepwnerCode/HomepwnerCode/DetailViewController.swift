//
//  DetailViewController.swift
//  Homepwner
//
//  Created by NHN on 2021/04/10.
//

import UIKit

class DetailViewController: UIViewController {
    var stackView: UIStackView!
    var dateCreated: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var nameField: SelectedUITextField! = SelectedUITextField()
    var serialField: SelectedUITextField! = SelectedUITextField()
    var valueField: SelectedUITextField! = SelectedUITextField()
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }
    
    override func viewDidLoad() {
        stackView = UIStackView()
        stackView.backgroundColor = .white
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let nameStackView = createStackView(text: "name", textField: nameField)
        let serialStackView = createStackView(text: "serial", textField: serialField)
        let valueStackView = createStackView(text: "value", textField: valueField)
        stackView.axis = .vertical
        stackView.spacing = CGFloat(6)
        stackView.addArrangedSubview(nameStackView)
        stackView.addArrangedSubview(serialStackView)
        stackView.addArrangedSubview(valueStackView)
        stackView.addArrangedSubview(dateCreated)
        dateCreated.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        dateCreated.textAlignment = .center
        
        // target + action 의 동작원리를 다시 알아보자 (엮어서 공부하자!!)
        // action을 외부에 등록을 해놓고, 해당 core영역에서 실행은 다른쪽에서 한다..
        let tapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(backgroundTapped))
        tapGestureRecognizer.numberOfTapsRequired = 1
        stackView.addGestureRecognizer(tapGestureRecognizer)
        
        let stackViewConstrains = [
            NSLayoutConstraint(item: stackView!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1.0, constant: 8.0),
            NSLayoutConstraint(item: stackView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: 8.0),
            NSLayoutConstraint(item: stackView!, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 8.0),
            NSLayoutConstraint(item: stackView!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 8.0),
            
            NSLayoutConstraint(item: nameField!, attribute: .width, relatedBy: .equal, toItem: serialField!, attribute: .width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: nameField!, attribute: .width, relatedBy: .equal, toItem: valueField!, attribute: .width, multiplier: 1.0, constant: 0.0),
            
            NSLayoutConstraint(item: nameField!, attribute: .leading, relatedBy: .equal, toItem: serialField!, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: nameField!, attribute: .leading, relatedBy: .equal, toItem: valueField!, attribute: .leading, multiplier: 1.0, constant: 0.0),
        ]
        stackViewConstrains.forEach({ $0.isActive = true })
    }
    
    func createStackView(text: String, textField: SelectedUITextField) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let label: UILabel! = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = text
            return label
        }()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        
        stackView.axis = .horizontal
        stackView.spacing = CGFloat(6)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        
        return stackView
    }
    
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
        
        view.endEditing(true)
        
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
    
    @objc func backgroundTapped(_ gestureRecognizer: UIGestureRecognizer) {
        // 어느 텍스트필드가 first responder인지 확인하고 resignFirstResponder 호출
        view.endEditing(true)
    }
}

extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return called")
        textField.resignFirstResponder()
        return true
    }
}
