//
//  WeatherAPIEndpointsTests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class WeatherAPIEndpointsTests: XCTestCase {

    func testWeatherEndpointReturnsValidURLRequest() {
        let city = "London"
        let days = 5
        
        let request = APIEndpoints.weather(city: city, days: days)
        XCTAssertNotNil(request)
        
        guard let url = request?.url else {
            XCTFail("URLRequest URL should not be nil")
            return
        }
        
        let urlString = url.absoluteString
        XCTAssertTrue(urlString.contains("forecast.json"))
        XCTAssertTrue(urlString.contains("key="))
        XCTAssertTrue(urlString.contains("q=London"))
        XCTAssertTrue(urlString.contains("days=5"))
    }
}
