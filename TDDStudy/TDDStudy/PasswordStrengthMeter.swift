//
//  PasswordStrength.swift
//  TDDStudy
//
//  Created by NHN on 2021/04/15.
//

import Foundation


enum PasswordStrength {
    case STRONG, NORMAL, INVALID, WEAK
}

class PasswordStrengthMeter {
    
    func meter(password: String?) -> PasswordStrength {
        guard let password = password,
              !password.isEmpty else {
            return .INVALID
        }
        let lengthEnough = password.count >= 8
        let containsNum: Bool = meetsContainingNumberCriteria(string: password)
        let containsUpp: Bool = meetsContainingUppercaseCriteria(string: password)
        
        if lengthEnough && !containsUpp && !containsNum {
            return .WEAK
        }
        if !lengthEnough && containsUpp && !containsNum {
            return .WEAK
        }
        if !lengthEnough && !containsUpp && containsNum {
            return .WEAK
        }
        
        if !lengthEnough {
            return .NORMAL
        }
        if !containsNum {
            return .NORMAL
        }
        if !containsUpp {
            return .NORMAL
        }
        return .STRONG
    }
    
    func meetsContainingNumberCriteria(string: String) -> Bool {
        for char in string {
            if char >= "0" && char <= "9" {
                return true
            }
        }
        return false
    }
    func meetsContainingUppercaseCriteria(string: String) -> Bool {
        for char in string {
            if char.isUppercase {
               return true
            }
        }
        return false
    }
}
