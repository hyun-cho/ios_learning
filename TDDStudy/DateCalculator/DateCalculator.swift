//
//  DateCalculator.swift
//  DateCalculator
//
//  Created by NHN on 2021/04/23.
//

import XCTest
@testable import TDDStudy

class DateCalculator: XCTestCase {
    var dateFormatter: DateFormatter = {
        var dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // 3.2
    func test_만원_납부하면_한달_뒤가_만료일이_됨() throws {
        var billingDate: Date = dateFormatter.date(from: "2019-03-01")
        let payAmount: Int = 10_000
        
        var cal: ExpiryDateCalculator = ExpiryDateCalculator()
        var expiryDate: Date = cal.calculateExpiryDate(billingDate, payAmount)
        
        XCTAssertEqual(dateFormatter.date(from: "2019-04-01"), expiryDate)

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
