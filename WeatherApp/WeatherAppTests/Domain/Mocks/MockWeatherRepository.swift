//
//  MockWeatherRepository.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import Foundation
@testable import WeatherApp

final class MockWeatherRepository: WeatherRepository {
    var weatherReportToReturn: WeatherReport?
    var errorToThrow: Error?
    
    private(set) var requestedCity: String?
    private(set) var requestedDays: Int?
    
    func getWeather(city: String, days: Int) async throws -> WeatherReport {
        requestedCity = city
        requestedDays = days
        
        if let error = errorToThrow {
            throw error
        }
        
        guard let report = weatherReportToReturn else {
            fatalError("MockWeatherRepository was called without setting a response.")
        }
        return report
    }
}
