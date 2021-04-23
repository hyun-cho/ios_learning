//
//  PayData.swift
//  TDDStudy
//
//  Created by NHN on 2021/04/23.
//

import Foundation

struct PayData {
    private(set) var firstBillingDate: Date = Date()
    private(set) var billingDate: Date = Date()
    private(set) var payAmount: Int = 0
    
    static func builder() -> Builder {
        return Builder()
    }
    
    class Builder {
        private var data: PayData = PayData()
        
        func firstBillingDate(_ firstBillingDate: Date) -> Builder {
            data.firstBillingDate = firstBillingDate
            return self
        }
        func billingDate(_ billingDate: Date) -> Builder {
            data.billingDate = billingDate
            return self
        }
        
        func payAmount(_ payAmount: Int) -> Builder {
            data.payAmount = payAmount
            return self
        }
        
        func build() -> PayData {
            return data
        }
    }
}
