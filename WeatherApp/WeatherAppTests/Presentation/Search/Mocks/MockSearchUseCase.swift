//
//  MockSearchUseCase.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import Foundation
@testable import WeatherApp

final class MockSearchUseCase: SearchUseCaseProtocol {
    var result: Result<[SearchModel], Error>?

    func getCities(city: String) async throws -> [SearchModel] {
        switch result {
        case .success(let report):
            return report
        case .failure(let error):
            throw error
        case .none:
            fatalError("MockSearchUseCase result not set")
        }
    }
}
