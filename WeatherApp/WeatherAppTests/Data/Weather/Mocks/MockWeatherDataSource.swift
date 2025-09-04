//
//  MockWeatherDataSource.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import Foundation
@testable import WeatherApp

final class MockWeatherDataSource: WeatherDataSource {
    var responseToReturn: WeatherResponse?
    var errorToThrow: Error?
    
    func fetchWeather(city: String, days: Int) async throws -> WeatherResponse {
        if let error = errorToThrow {
            throw error
        }
        guard let response = responseToReturn else {
            fatalError("No response set for mock")
        }
        return response
    }
}
