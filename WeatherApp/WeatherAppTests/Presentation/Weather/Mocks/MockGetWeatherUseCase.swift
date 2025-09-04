//
//  MockGetWeatherUseCase.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import Foundation
@testable import WeatherApp

final class MockGetWeatherUseCase: GetWeatherUseCaseProtocol {
    var result: Result<WeatherReport, Error>?

    func getWeather(city: String, days: Int) async throws -> WeatherReport {
        switch result {
        case .success(let report):
            return report
        case .failure(let error):
            throw error
        case .none:
            fatalError("MockGetWeatherUseCase result not set")
        }
    }
}
