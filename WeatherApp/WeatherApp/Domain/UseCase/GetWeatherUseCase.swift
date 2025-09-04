//
//  GetWeatherUseCase.swift
//  WeatherApp
//
//  Created on 03/09/25.
//

import Foundation

protocol GetWeatherUseCaseProtocol {
    func getWeather(city: String, days: Int) async throws -> WeatherReport
}

final class GetWeatherUseCase: GetWeatherUseCaseProtocol {
    private let repository: WeatherRepository
    
    init(repository: WeatherRepository) {
        self.repository = repository
    }
    
    func getWeather(city: String, days: Int) async throws -> WeatherReport {
        return try await repository.getWeather(city: city, days: days)
    }
}
