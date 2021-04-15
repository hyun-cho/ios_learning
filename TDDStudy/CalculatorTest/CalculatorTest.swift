//
//  CalculatorTest.swift
//  CalculatorTest
//
//  Created by NHN on 2021/04/15.
//

import XCTest
@testable import TDDStudy

class CalculatorTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let result: Int = Calculator.plus(1, 2);
        XCTAssertEqual(3, result)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
