//
//  MockAPIClient.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import Foundation
@testable import WeatherApp

final class MockAPIClient<T: Decodable>: APIClientProtocol {
    var result: Result<T, Error>?
    var lastRequest: URLRequest?
    
    func request<U>(_ endpoint: URLRequest) async throws -> U where U : Decodable {
        lastRequest = endpoint
        guard let result = result as? Result<U, Error> else {
            fatalError("MockAPIClient result type mismatch")
        }
        switch result {
        case .success(let value):
            return value
        case .failure(let error):
            throw error
        }
    }
}
