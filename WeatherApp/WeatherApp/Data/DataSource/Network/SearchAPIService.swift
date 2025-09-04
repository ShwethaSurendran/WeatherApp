//
//  WeatherAPIService.swift
//  WeatherApp
//
//

import Foundation

final class SearchAPIService: SearchDataSource {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchCities(city: String) async throws -> [SearchResponse] {
        guard let request = APIEndpoints.search(city: city) else {
            throw URLError(.badURL)
        }
        return try await apiClient.request(request)
    }
}
