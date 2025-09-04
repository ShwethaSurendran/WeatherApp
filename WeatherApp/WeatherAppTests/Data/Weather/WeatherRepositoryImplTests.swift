//
//  WeatherRepositoryImplTests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class WeatherRepositoryImplTests: XCTestCase {
    
    func testGetWeatherReturnsDomainModel() async throws {
        let dummyResponse = WeatherResponse(
            location: Location(name: "Melbourne", region: "Victoria", country: "Australia", localtime: "2025-09-04 10:00"),
            current: Current(temp_c: 20.0, condition: Condition(text: "Cloudy", icon: "//cdn.weatherapi.com/icon.png"), wind_kph: 10, humidity: 60, cloud: 10, feelslike_c: 21, uv: 5),
            forecast: Forecast(forecastday: [])
        )
        
        let mockDataSource = MockWeatherDataSource()
        mockDataSource.responseToReturn = dummyResponse
        
        let repository = WeatherRepositoryImpl(dataSource: mockDataSource)
        let report = try await repository.getWeather(city: "Melbourne", days: 3)
        
        XCTAssertEqual(report.city, "Melbourne")
        XCTAssertEqual(report.current.temperatureC, 20.0)
        XCTAssertEqual(report.current.condition.text, "Cloudy")
    }
    
    func testGetWeatherThrowsError() async {
        let mockDataSource = MockWeatherDataSource()
        mockDataSource.errorToThrow = URLError(.notConnectedToInternet)
        
        let repository = WeatherRepositoryImpl(dataSource: mockDataSource)
        
        do {
            _ = try await repository.getWeather(city: "Melbourne", days: 3)
            XCTFail("Method was expected to throw an error, but it did not.")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .notConnectedToInternet)
        }
    }
}
