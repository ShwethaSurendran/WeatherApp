//
//  WeatherRepository.swift
//  WeatherApp
//
//

import Foundation

final class WeatherRepositoryImpl: WeatherRepository {
    private let dataSource: WeatherDataSource
    
    init(dataSource: WeatherDataSource) {
        self.dataSource = dataSource
    }
    
    func getWeather(city: String, days: Int) async throws -> WeatherReport {
        let response = try await dataSource.fetchWeather(city: city, days: days)
        return response.toDomain()
    }
}
