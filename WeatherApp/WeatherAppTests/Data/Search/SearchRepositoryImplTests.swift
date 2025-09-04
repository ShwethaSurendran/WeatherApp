//
//  SearchRepositoryImplTests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class SearchRepositoryImplTests: XCTestCase {
    
    func testGetCitiesReturnsDomainModel() async throws {
        let dummyResponse = [
            SearchResponse(id: 1, name: "London", country: "UK"),
            SearchResponse(id: 2, name: "Paris", country: "France")
        ]
        
        let mockDataSource = MockSearchDataSource()
        mockDataSource.responseToReturn = dummyResponse
        
        let repository = SearchRepositoryImpl(dataSource: mockDataSource)
        let result = try await repository.getCities(city: "Paris")
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.last?.name, "Paris")
    }
    
    func testGetCitiesThrowsError() async {
        let mockDataSource = MockSearchDataSource()
        mockDataSource.errorToThrow = URLError(.notConnectedToInternet)
        
        let repository = SearchRepositoryImpl(dataSource: mockDataSource)
        
        do {
            _ = try await repository.getCities(city: "Melbourne")
            XCTFail("Method was expected to throw an error, but it did not.")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .notConnectedToInternet)
        }
    }
}
