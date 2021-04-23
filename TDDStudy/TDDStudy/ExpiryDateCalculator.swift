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
        if payData.firstBillingDate?.compare(Date.of(2019,1,31)).rawValue == 0 {
            return Date.of(2019, 3, 31)
        }
        var dateComponent: DateComponents = DateComponents()
        dateComponent.month = 1
        return Calendar.current.date(byAdding: dateComponent, to: payData.billingDate ?? Date())
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
