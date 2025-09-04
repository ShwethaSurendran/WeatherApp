//
//  WeatherReportToUITests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class WeatherReportToUITests: XCTestCase {
    func testToUIMapsCorrectly() {
        let report = WeatherReport(
            city: "Melbourne",
            region: "Victoria",
            country: "Australia",
            localtime: "2025-09-04 15:30",
            current: CurrentWeather(
                temperatureC: 23.7,
                condition: ConditionWeather(text: "Sunny", icon: URL(string: "https://cdn.weatherapi.com/sunny.png")),
                windSpeedKmph: 12.2,
                humidity: 55.4,
                cloudcover: 20.5,
                feelslikeC: 25.1,
                uvIndex: 4.3
            ),
            daily: [
                DailyWeather(
                    date: "2025-09-05",
                    maxTempC: 28.4,
                    minTempC: 18.2,
                    condition: ConditionWeather(text: "Cloudy", icon: URL(string: "https://cdn.weatherapi.com/cloud.png"))
                )
            ]
        )
        
        let uiModel = report.toUI()
        
        XCTAssertEqual(uiModel.location, "Melbourne, Australia")
        XCTAssertEqual(uiModel.condition, "Sunny")
        XCTAssertEqual(uiModel.temperature, "23°C")
        XCTAssertEqual(uiModel.daily.count, 1)
        XCTAssertEqual(uiModel.weatherDetails.count, 5)
        XCTAssertEqual(uiModel.weatherDetails[0].name, "Wind")
        XCTAssertTrue(uiModel.weatherDetails[0].value.contains("km/h"))
    }
}
