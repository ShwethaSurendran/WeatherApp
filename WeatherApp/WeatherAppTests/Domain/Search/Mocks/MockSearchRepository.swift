//
//  MockSearchRepository.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import Foundation
@testable import WeatherApp

final class MockSearchRepository: SearchRepository {
    var searchModelToReturn: [SearchModel]?
    var errorToThrow: Error?
    
    private(set) var requestedCity: String?
    
    func getCities(city: String) async throws -> [SearchModel] {
        requestedCity = city
        
        if let error = errorToThrow {
            throw error
        }
        
        guard let report = searchModelToReturn else {
            fatalError("MockSearchRepository was called without setting a response.")
        }
        return report
    }
}
