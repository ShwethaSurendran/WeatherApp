//
//  MockSearchDataSource.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import Foundation
@testable import WeatherApp


final class MockSearchDataSource: SearchDataSource {
    var responseToReturn: [SearchResponse]?
    var errorToThrow: Error?
    
    func fetchCities(city: String) async throws -> [SearchResponse] {
        if let error = errorToThrow {
            throw error
        }
        guard let response = responseToReturn else {
            fatalError("No response set for mock")
        }
        return response
    }
}
