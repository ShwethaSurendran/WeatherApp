//
//  WeatherRepository.swift
//  WeatherApp
//
//

import Foundation

final class SearchRepositoryImpl: SearchRepository {
    private let dataSource: SearchDataSource
    
    init(dataSource: SearchDataSource) {
        self.dataSource = dataSource
    }
    
    func getCities(city: String) async throws -> [SearchModel] {
        let response = try await dataSource.fetchCities(city: city)
        return response.map { $0.toDomain() }
    }
}
