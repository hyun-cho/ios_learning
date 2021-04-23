//
//  ExpiryDateCalculator.swift
//  TDDStudy
//
//  Created by NHN on 2021/04/23.
//

import Foundation

class ExpiryDateCalculator {
    // 3.5
    func calculateExpiryDate(_ payData: PayData) -> Date? {
        let addedMonths = 1
        var oneMonthDateComponent: DateComponents = DateComponents()
        oneMonthDateComponent.month = addedMonths
        
        if let firstBillingDate = payData.firstBillingDate {
            let candidateExp: Date? = Calendar.current.date(byAdding: oneMonthDateComponent, to: payData.billingDate ?? Date())
            let firstBillingDateComponent = Calendar.current.dateComponents([.day], from: firstBillingDate)
            let candidateExpComponent = Calendar.current.dateComponents([.year, .month, .day], from: candidateExp!)
            if firstBillingDateComponent.day != candidateExpComponent.day {
                return Date.of(candidateExpComponent.year!, candidateExpComponent.month!, firstBillingDateComponent.day!)
            }
        }
        return Calendar.current.date(byAdding: oneMonthDateComponent, to: payData.billingDate ?? Date())
    }
}

extension Date {
    static func of(_ year: Int, _ month: Int, _ day: Int) -> Date {
        let dateFormatter: DateFormatter = {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter
        }()
        return dateFormatter.date(from: "\(year)-\(month)-\(day)")!
    }
    
}
