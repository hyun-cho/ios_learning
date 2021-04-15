//
//  PasswordStrength.swift
//  TDDStudy
//
//  Created by NHN on 2021/04/15.
//

import Foundation


enum PasswordStrength {
    case STRONG
}

class PasswordStrengthMeter {
    
    func meter(password: String) -> PasswordStrength {
        return PasswordStrength.STRONG
    }
}
