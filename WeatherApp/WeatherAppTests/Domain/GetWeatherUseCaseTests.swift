//
//  GetWeatherUseCaseTests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class GetWeatherUseCaseTests: XCTestCase {
    
    func testGetWeatherSuccessReturnsReport() async throws {
        let condition = ConditionWeather(text: "Sunny", icon: nil)
        let current = CurrentWeather(
            temperatureC: 22.0,
            condition: condition,
            windSpeedKmph: 9.0,
            humidity: 60,
            cloudcover: 10,
            feelslikeC: 21.0,
            uvIndex: 4.0
        )
        let daily = [
            DailyWeather(date: "2025-09-05", maxTempC: 28, minTempC: 18, condition: condition)
        ]
        let mockReport = WeatherReport(
            city: "Melbourne",
            region: "Victoria",
            country: "Australia",
            localtime: "2025-09-04 10:00",
            current: current,
            daily: daily
        )
        
        let mockRepository = MockWeatherRepository()
        mockRepository.weatherReportToReturn = mockReport
        
        let useCase = GetWeatherUseCase(repository: mockRepository)
        
        let result = try await useCase.getWeather(city: "Melbourne", days: 1)
        
        // Then
        XCTAssertEqual(result.city, "Melbourne")
        XCTAssertEqual(mockRepository.requestedCity, "Melbourne")
        XCTAssertEqual(mockRepository.requestedDays, 1)
    }
    
    func testGetWeatherThrowsError() async {
        let mockRepository = MockWeatherRepository()
        mockRepository.errorToThrow = URLError(.notConnectedToInternet)
        
        let useCase = GetWeatherUseCase(repository: mockRepository)
        
        do {
            _ = try await useCase.getWeather(city: "Melbourne", days: 1)
            XCTFail("Method was expected to throw an error, but it did not.")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .notConnectedToInternet)
        }
    }
}
