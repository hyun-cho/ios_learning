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
        var dateComponent: DateComponents = DateComponents()
        dateComponent.month = 1
        return Calendar.current.date(byAdding: dateComponent, to: payData.billingDate)
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
