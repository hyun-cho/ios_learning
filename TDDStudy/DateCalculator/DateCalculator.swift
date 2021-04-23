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

    // 3.6
    func test_만원_납부하면_한달_뒤가_만료일이_됨() throws {
        assertExpiryDate(Date.of(2019, 3, 1), 10_000, Date.of(2019, 4, 1))
        assertExpiryDate(Date.of(2019, 5, 5), 10_000, Date.of(2019, 6, 5))
    }
    
    // 3-7
    func test_납부일과_한달_뒤_일자가_같지_않음() throws {
        assertExpiryDate(Date.of(2019, 1, 31), 10_000, Date.of(2019, 2, 28))
        assertExpiryDate(Date.of(2019, 5, 31), 10_000, Date.of(2019, 6, 30))
        assertExpiryDate(Date.of(2020, 1, 31), 10_000, Date.of(2020, 2, 29))
    }
    
    func assertExpiryDate(_ billingDate: Date, _ payAmount: Int, _ expectedExpiryDate: Date) {
        let cal: ExpiryDateCalculator = ExpiryDateCalculator()
        let expiryDate: Date? = cal.calculateExpiryDate(billingDate, payAmount)
        
        XCTAssertEqual(expectedExpiryDate, expiryDate)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
