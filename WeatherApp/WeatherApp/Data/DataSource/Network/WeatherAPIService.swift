//
//  WeatherAPIService.swift
//  WeatherApp
//
//

import Foundation

final class WeatherAPIService: WeatherDataSource {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchWeather(city: String, days: Int) async throws -> WeatherResponse {
        guard let request = WeatherAPIEndpoints.weather(city: city, days: days) else {
            throw URLError(.badURL)
        }
        return try await apiClient.request(request)
    }
}
