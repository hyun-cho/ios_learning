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
        let addedMonths = payData.payAmount! == 100_000 ? 12 : payData.payAmount! / 10_000
        var monthDateComponent: DateComponents = DateComponents()
        monthDateComponent.month = addedMonths

        if payData.firstBillingDate != nil {
            return expiryDateUsingFirstBillingDate(payData: payData, monthDateComponent: monthDateComponent)
        }
        else {
            return Calendar.current.date(byAdding: monthDateComponent, to: payData.billingDate ?? Date())
        }
    }
    
    func expiryDateUsingFirstBillingDate(payData: PayData, monthDateComponent: DateComponents) -> Date? {
        if let firstBillingDate = payData.firstBillingDate {
            var candidateExp: Date = (payData.billingDate?.addingMonth(monthDateComponent))!
            if firstBillingDate.day! != candidateExp.day! {
                if firstBillingDate.day! > candidateExp.dayLength {
                    candidateExp.day = candidateExp.dayLength
                }
                else {
                    candidateExp.day = firstBillingDate.day!
                }
            }
            return candidateExp
        }
        return nil
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
    
    func addingMonth(_ month: DateComponents) -> Date?{
        return Calendar.current.date(byAdding: month, to: self)
    }
    var day: Int? {
        get {
            return Calendar.current.dateComponents([.day], from: self).day
        }
        set(value) {
            let component = Calendar.current.dateComponents([.year, .month], from: self)
            self = Date.of(component.year!, component.month!, value!)
        }
    }
    var month: Int? {
        get {
            return Calendar.current.dateComponents([.month], from: self).month
        }
    }
    var year: Int? {
        get {
            return Calendar.current.dateComponents([.year], from: self).year
        }
    }
    var dayLength: Int {
        get {
            let currentMonth = Calendar.current.dateComponents([.year, .month], from: self)
            let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date.of(currentMonth.year!, currentMonth.month!, 1))
            let endOfMonth = Calendar.current.date(byAdding: .day, value: -1, to: nextMonth!)
            return Calendar.current.dateComponents([.day], from: endOfMonth!).day!
        }
    }
    
    func compareDay(_ another: Date?) -> Bool {
        guard let another = another else {
            return false
        }
        
        let firstBillingDateComponent = Calendar.current.dateComponents([.day], from: another)
        let candidateExpComponent = Calendar.current.dateComponents([.day], from: another)
        
        return firstBillingDateComponent.day! != candidateExpComponent.day!
    }
}
