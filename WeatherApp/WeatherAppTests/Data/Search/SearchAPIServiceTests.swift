//
//  SearchAPIServiceTests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class SearchAPIServiceTests: XCTestCase {
    
    func testFetchCitiesSuccess() async throws {
        let dummyResponse = [
            SearchResponse(id: 1, name: "London", country: "UK"),
            SearchResponse(id: 2, name: "Paris", country: "France")
        ]
        
        let mockApiClient = MockAPIClient<[SearchResponse]>()
        mockApiClient.result = .success(dummyResponse)
        
        let service = SearchAPIService(apiClient: mockApiClient)
        let result = try await service.fetchCities(city: "London")
        
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, "London")
        XCTAssertTrue(mockApiClient.lastRequest?.url?.absoluteString.contains("London") ?? false)
    }
    
    func testFetchCitiesFailure() async {
        let mockApiClient = MockAPIClient<[SearchResponse]>()
        mockApiClient.result = .failure(URLError(.badServerResponse))
        
        let service = SearchAPIService(apiClient: mockApiClient)
        
        do {
            _ = try await service.fetchCities(city: "Melbourne")
            XCTFail("Method was expected to throw an error, but it did not.")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .badServerResponse)
        }
    }
}
