//
//  ExpiryDateCalculator.swift
//  TDDStudy
//
//  Created by NHN on 2021/04/23.
//

import Foundation

class ExpiryDateCalculator {
    func calculateExpiryDate(_ billingDate: Date, _ payAmount: Int) -> Date{
        return Date.of(2019, 4, 1)
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
