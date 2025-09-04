//
//  WeatherAPIEndpointsTests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class SearchAPIEndpointsTests: XCTestCase {

    func testSearchEndpointReturnsValidURLRequest() {
        let city = "London"
        
        let request = APIEndpoints.search(city: city)
        XCTAssertNotNil(request)
        
        guard let url = request?.url else {
            XCTFail("URLRequest URL should not be nil")
            return
        }
        
        let urlString = url.absoluteString
        XCTAssertTrue(urlString.contains("search.json"))
        XCTAssertTrue(urlString.contains("key="))
        XCTAssertTrue(urlString.contains("q=London"))
    }
}
