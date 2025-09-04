//
//  WeatherAPIServiceTests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class WeatherAPIServiceTests: XCTestCase {
    
    func testFetchWeatherSuccess() async throws {
        let dummyResponse = WeatherResponse(
            location: Location(name: "Melbourne", region: "Victoria", country: "Australia", localtime: "2025-09-04 10:00"),
            current: Current(temp_c: 20.0, condition: Condition(text: "Sunny", icon: "//cdn.weatherapi.com/icon.png"), wind_kph: 10, humidity: 60, cloud: 10, feelslike_c: 21, uv: 5),
            forecast: Forecast(forecastday: [])
        )
        
        let mockApiClient = MockAPIClient<WeatherResponse>()
        mockApiClient.result = .success(dummyResponse)
        
        let service = WeatherAPIService(apiClient: mockApiClient)
        let result = try await service.fetchWeather(city: "Melbourne", days: 3)
        
        XCTAssertEqual(result.location.name, "Melbourne")
        XCTAssertEqual(result.current.temp_c, 20.0)
        XCTAssertNotNil(mockApiClient.lastRequest)
        XCTAssertTrue(mockApiClient.lastRequest?.url?.absoluteString.contains("Melbourne") ?? false)
    }
    
    func testFetchWeatherFailure() async {
        let mockApiClient = MockAPIClient<WeatherResponse>()
        mockApiClient.result = .failure(URLError(.badServerResponse))
        
        let service = WeatherAPIService(apiClient: mockApiClient)
        
        do {
            _ = try await service.fetchWeather(city: "Melbourne", days: 3)
            XCTFail("Method was expected to throw an error, but it did not.")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .badServerResponse)
        }
    }
}
