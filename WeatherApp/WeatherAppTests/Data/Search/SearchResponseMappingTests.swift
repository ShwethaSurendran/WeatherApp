//
//  SearchResponseMappingTests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class SearchResponseMappingTests: XCTestCase {
    
    func testToDomainMapping() {
        let response = SearchResponse(id: 1, name: "Melbourne", country: "Australia")
        
        let domain = response.toDomain()
        
        XCTAssertEqual(domain.name, "Melbourne")
        XCTAssertEqual(domain.country, "Australia")
    }
}
