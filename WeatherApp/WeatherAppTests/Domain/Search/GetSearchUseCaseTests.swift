//
//  GetSearchUseCaseTests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class GetSearchUseCaseTests: XCTestCase {
    
    func testGetCitiesSuccessReturnsModel() async throws {
        let mockData = [
            SearchModel(name: "London", id: 1, country: "UK"),
            SearchModel(name: "Paris", id: 2, country: "France"),
            SearchModel(name: "Melbourne", id: 2, country: "Australia")
        ]
        
        let mockRepository = MockSearchRepository()
        mockRepository.searchModelToReturn = mockData
        
        let useCase = SearchUseCase(repository: mockRepository)
        
        let result = try await useCase.getCities(city: "Melbourne")
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 3)
        XCTAssertEqual(mockRepository.requestedCity, "Melbourne")
    }
    
    func testGetCitiesThrowsError() async {
        let mockRepository = MockSearchRepository()
        mockRepository.errorToThrow = URLError(.notConnectedToInternet)
        
        let useCase = SearchUseCase(repository: mockRepository)
        
        do {
            _ = try await useCase.getCities(city: "Melbourne")
            XCTFail("Method was expected to throw an error, but it did not.")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .notConnectedToInternet)
        }
    }
}
