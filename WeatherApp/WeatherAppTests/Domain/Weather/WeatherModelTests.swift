//
//  WeatherModelTests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class WeatherModelTests: XCTestCase {
    func testWeatherReportInitialization() {
        let condition = ConditionWeather(text: "Cloudy", icon: URL(string: "https://cdn.weatherapi.com/icon.png"))
        let current = CurrentWeather(
            temperatureC: 25.0,
            condition: condition,
            windSpeedKmph: 10.0,
            humidity: 80,
            cloudcover: 50,
            feelslikeC: 26.0,
            uvIndex: 5.0
        )
        let daily = [
            DailyWeather(date: "2025-09-05", maxTempC: 30, minTempC: 20, condition: condition),
            DailyWeather(date: "2025-09-06", maxTempC: 32, minTempC: 21, condition: condition)
        ]
        
        let report = WeatherReport(
            city: "Melbourne",
            region: "Victoria",
            country: "Australia",
            localtime: "2025-09-04 12:00",
            current: current,
            daily: daily
        )
        
        XCTAssertEqual(report.city, "Melbourne")
        XCTAssertEqual(report.region, "Victoria")
        XCTAssertEqual(report.country, "Australia")
        XCTAssertEqual(report.localtime, "2025-09-04 12:00")
        XCTAssertEqual(report.current.temperatureC, 25.0)
        XCTAssertEqual(report.daily.count, 2)
    }
    
    func testConditionWeatherIconIsOptional() {
        let condition = ConditionWeather(text: "Clear", icon: nil)
        XCTAssertEqual(condition.text, "Clear")
        XCTAssertNil(condition.icon)
    }
}
