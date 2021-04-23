//
//  DateCalculator.swift
//  DateCalculator
//
//  Created by NHN on 2021/04/23.
//

import XCTest
@testable import TDDStudy

class DateCalculator: XCTestCase {
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // 3.4
    func test_만원_납부하면_한달_뒤가_만료일이_됨() throws {
        let billingDate: Date = Date.of(2019, 3, 1)
        let payAmount: Int = 10_000
        
        let cal: ExpiryDateCalculator = ExpiryDateCalculator()
        let expiryDate: Date = cal.calculateExpiryDate(billingDate, payAmount)
        
        XCTAssertEqual(Date.of(2019,4,1), expiryDate)
        
        let billingDate2: Date = Date.of(2019,5,5)
        let payAmount2 = 10_000
        
        let cal2: ExpiryDateCalculator = ExpiryDateCalculator()
        let expiryDate2: Date = cal2.calculateExpiryDate(billingDate2, payAmount2)
        
        XCTAssertEqual(Date.of(2019,6,05), expiryDate2)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
