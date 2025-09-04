//
//  SearchModelToUITests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class SearchModelToUITests: XCTestCase {
    func testToUIMapsCorrectly() {
        let model = SearchModel(name: "London", id: 1, country: "UK")
        
        let uiModel = model.toUI()
        
        XCTAssertEqual(model.name, "London")
        XCTAssertEqual(model.country, "UK")
    }
}
