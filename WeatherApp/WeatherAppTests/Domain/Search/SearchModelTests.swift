//
//  SearchModelTests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class SearchModelTests: XCTestCase {
    func testSearchModelInitialization() {
        let model = SearchModel(name: "Adelaide", id: 1, country: "AUS")
        
        XCTAssertEqual(model.name, "Adelaide")
        XCTAssertEqual(model.country, "AUS")
    }
}
