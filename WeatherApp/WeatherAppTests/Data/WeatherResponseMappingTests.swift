//
//  WeatherResponseMappingTests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class WeatherResponseMappingTests: XCTestCase {
    
    func testToDomainMapping() {
        let response = WeatherResponse(
            location: Location(name: "Melbourne", region: "Victoria", country: "Australia", localtime: "2025-09-04 10:00"),
            current: Current(temp_c: 18.5, condition: Condition(text: "Rainy", icon: "//cdn.weatherapi.com/rain.png"), wind_kph: 8, humidity: 80, cloud: 90, feelslike_c: 18, uv: 2),
            forecast: Forecast(forecastday: [
                ForecastDay(date: "2025-09-05", day: Day(maxtemp_c: 22.0, mintemp_c: 15.0, condition: Condition(text: "Cloudy", icon: "//cdn.weatherapi.com/cloud.png"))),
                ForecastDay(date: "2025-09-06", day: Day(maxtemp_c: 23.0, mintemp_c: 14.0, condition: Condition(text: "Sunny", icon: "//cdn.weatherapi.com/sunny.png")))
            ])
        )
        
        let domain = response.toDomain()
        
        XCTAssertEqual(domain.city, "Melbourne")
        XCTAssertEqual(domain.current.temperatureC, 18.5)
        XCTAssertEqual(domain.current.condition.text, "Rainy")
        XCTAssertEqual(domain.daily.count, 2)
        XCTAssertEqual(domain.daily[0].date, "2025-09-05")
        XCTAssertEqual(domain.daily[0].maxTempC, 22.0)
        XCTAssertEqual(domain.daily[0].condition.text, "Cloudy")
        XCTAssertEqual(domain.daily[1].condition.icon?.absoluteString, "https://cdn.weatherapi.com/sunny.png")
    }
}
