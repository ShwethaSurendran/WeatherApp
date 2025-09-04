//
//  GetWeatherUseCase.swift
//  WeatherApp
//
//  Created on 03/09/25.
//

import Foundation

protocol SearchUseCaseProtocol {
    func getCities(city: String) async throws -> [SearchModel]
}

final class SearchUseCase: SearchUseCaseProtocol {
    private let repository: SearchRepository
    
    init(repository: SearchRepository) {
        self.repository = repository
    }
    
    func getCities(city: String) async throws -> [SearchModel] {
        return try await repository.getCities(city: city)
    }
}
