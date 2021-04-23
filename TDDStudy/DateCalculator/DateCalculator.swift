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
        assertExpiryDate(PayData.builder().billingDate(Date.of(2019, 3, 1)).payAmount(10_000).build(), Date.of(2019, 4, 1))
        assertExpiryDate(PayData.builder().billingDate(Date.of(2019, 5, 5)).payAmount(10_000).build(), Date.of(2019, 6, 5))
    }
    
    // 3-7
    func test_납부일과_한달_뒤_일자가_같지_않음() throws {
        assertExpiryDate(PayData.builder().billingDate(Date.of(2019, 1, 31)).payAmount(10_000).build(), Date.of(2019, 2, 28))
        assertExpiryDate(PayData.builder().billingDate(Date.of(2019, 5, 31)).payAmount(10_000).build(), Date.of(2019, 6, 30))
        assertExpiryDate(PayData.builder().billingDate(Date.of(2020, 1, 31)).payAmount(10_000).build(), Date.of(2020, 2, 29))
    }
    
    // 3-10
    func test_첫_납부일과_만료일_일자가_다를때_만원_납부() {
        let payData: PayData = PayData.builder()
            .firstBillingDate(Date.of(2019, 1, 31))
            .billingDate(Date.of(2019, 2, 28))
            .payAmount(10_000)
            .build()
        assertExpiryDate(payData, Date.of(2019, 3, 31))
        
        let payData2: PayData = PayData.builder()
            .firstBillingDate(Date.of(2019, 1, 30))
            .billingDate(Date.of(2019, 2, 28))
            .payAmount(10_000)
            .build()
        assertExpiryDate(payData2, Date.of(2019, 3, 30))
        
        let payData3: PayData = PayData.builder()
            .firstBillingDate(Date.of(2019, 5, 31))
            .billingDate(Date.of(2019, 6, 30))
            .payAmount(10_000)
            .build()
        assertExpiryDate(payData3, Date.of(2019, 7, 31))
    }
    
    // 3-18
    func test_이만원_이상_납부하면_비례해서_만료일_계산() {
        let payData: PayData = PayData.builder()
            .billingDate(Date.of(2019, 3, 1))
            .payAmount(20_000)
            .build()
        assertExpiryDate(payData, Date.of(2019, 5, 1))
    }
    
    
    func assertExpiryDate(_ payData: PayData, _ expectedExpiryDate: Date) {
        let cal: ExpiryDateCalculator = ExpiryDateCalculator()
        let expiryDate: Date? = cal.calculateExpiryDate(payData)
        
        XCTAssertEqual(expectedExpiryDate, expiryDate)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
