//
//  PasswordStrengthMeterTest.swift
//  PasswordStrengthMeterTest
//
//  Created by NHN on 2021/04/15.
//

import XCTest
@testable import TDDStudy

class PasswordStrengthMeterTest: XCTestCase {
    private var meter: PasswordStrengthMeter = PasswordStrengthMeter()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // 첫번째 : 모든 조건을 충족하는 경우
    func testMeetsAllCriteriaThenStrong() throws {
        assertStrength(password: "ab12!@AB", expStr: .STRONG)
        assertStrength(password: "abc1!Add", expStr: .STRONG)
    }
    
    // 두번째 : 길이만 8글자 미만이고 나머지 조건은 충족하는 경우
    func testMeetsOtherCriteriExceptForLengthThenNormal() throws {
        assertStrength(password: "ab12!@A", expStr: .NORMAL)
    }
    
    // 세번째 : 숫자를 포함하지 않고 나머지 조건은 충족하는 경우
    func testMeetsOtherCriteriaExceptForNumberThenNormal() throws {
        assertStrength(password: "ab!@ABqwer", expStr: .NORMAL)
    }
    
    // 네번째 : 빈 패스워드가 오는 경우
    func testNullInputThenInvalid() throws {
        assertStrength(password: nil, expStr: .INVALID)
        assertStrength(password: "", expStr: .INVALID)
    }
    
    // 다섯번째 : 대문자를 포함하지 않고 나머지 조건을 충족하는 경우
    func testMeetsOtherCriteriaExceptForUppercaseThenNormal() {
        assertStrength(password: "ab12!@df", expStr: .NORMAL)
    }
    
    // 여섯번째 : 길이가 8글자 이상인 조건만 충족하는 경우
    func testMeetsOnlyLengthCriteriaThenWeak() {
        assertStrength(password: "abdefghi", expStr: .WEAK)
    }
    
    // 일곱번째 : 숫자 포함 조건만 충족하는 경우
    func testMeetsOnlyNumCriteriaThenWeak() {
        assertStrength(password: "12345", expStr: .WEAK)
    }
    
    // 여덟번째 : 대문자 포함 조건만 충족하는 경우
    func testMeetsOnlyUpperCriteriaThenWeak() {
        assertStrength(password: "ABZEF", expStr: .WEAK)
    }
    
    // 아홉번째 : 아무 조건도 충족하지 않은 경우
    func testMeetsNoCriteriaThenWeak() {
        assertStrength(password: "abc", expStr: .WEAK)
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func assertStrength(password: String?, expStr :PasswordStrength) {
        let result = meter.meter(password: password)
        // NORMAL을 추가했고, 오류가 발생했으므로 본 코드를 수정한다.
        XCTAssertEqual(result, expStr)
    }

}
