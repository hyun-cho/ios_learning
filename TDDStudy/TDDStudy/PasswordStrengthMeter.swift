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
        let metCount: Int = getMetCriteriaCount(string: password)
        
        if metCount <= 1 {
            return .WEAK
        }
        if metCount == 2 {
            return .NORMAL
        }
        return .STRONG
    }
    
    func getMetCriteriaCount(string: String) -> Int {
        var metCount: Int = 0
        if string.count >= 8 {
            metCount += 1
        }
        if meetsContainingNumberCriteria(string: string) {
            metCount += 1
        }
        if meetsContainingUppercaseCriteria(string: string) {
            metCount += 1
        }
        return metCount
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
