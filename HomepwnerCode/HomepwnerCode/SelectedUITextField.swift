//
//  SelectedUITextField.swift
//  Homepwner
//
//  Created by NHN on 2021/04/12.
//

import UIKit

class SelectedUITextField: UITextField {
    override func becomeFirstResponder() -> Bool {
        self.borderStyle = .none
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        self.borderStyle = .bezel
        return super.resignFirstResponder()
    }
}

