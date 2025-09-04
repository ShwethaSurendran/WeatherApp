//
//  StringDateFormatTests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class StringDateFormatTests: XCTestCase {
    
    func testConvertDateFormat_successfulConversion() {
        let originalDate = "2025-09-04 14:30"
        let result = originalDate.convertDateFormat(fromFormat: .yearMonthDayTime, toFormat: .yearMonthDay) ?? ""
        
        XCTAssertNotNil(result)
        XCTAssertFalse(result.isEmpty)
        XCTAssertNotEqual(result, originalDate)
        XCTAssertEqual(result, "2025-09-04")
    }
    
    func testConvertDateFormat_invalidInput_returnsNil() {
        let invalidDate = "nil"
        let result = invalidDate.convertDateFormat(fromFormat: .yearMonthDayTime, toFormat: .weekdayDayMonthYear)
        XCTAssertNil(result)
    }
    
    func testConvertDateFormat_invalidDateFormat_returnsNil() {
        let invalidDate = "2025-09-04"
        let result = invalidDate.convertDateFormat(fromFormat: .yearMonthDayTime, toFormat: .weekdayDayMonthYear)
        XCTAssertNil(result)
    }
}
