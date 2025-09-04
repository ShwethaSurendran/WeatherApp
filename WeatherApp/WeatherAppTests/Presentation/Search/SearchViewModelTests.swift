//
//  SearchViewModelTests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class SearchViewModelTests: XCTestCase {
    @MainActor
    func testLoadCitiesSuccess() async {
        let mockUseCase = MockSearchUseCase()
        let models = [SearchModel(name: "London", id: 1, country: "UK")]
        mockUseCase.result = .success(models)
        
        let viewModel = SearchViewModel(getSearchUseCase: mockUseCase)
        
        await viewModel.loadCities()
        
        guard case .complete(let model?) = viewModel.loadingState else {
            XCTFail("Expected .complete state with model")
            return
        }
        XCTAssertEqual(model.count, 1)
    }
    
    @MainActor
    func testLoadCitiesError() async {
        let mockUseCase = MockSearchUseCase()
        mockUseCase.result = .failure(URLError(.notConnectedToInternet))
        
        let viewModel = SearchViewModel(getSearchUseCase: mockUseCase)
        await viewModel.loadCities()
        guard case .error(let message) = viewModel.loadingState else {
            XCTFail("Expected .error state")
            return
        }
        XCTAssertTrue(!message.isEmpty)

    }
    
    @MainActor
    func testInitialLoadingStateIsLoading() {
        let mockUseCase = MockSearchUseCase()
        let viewModel = SearchViewModel(getSearchUseCase: mockUseCase)
        if case .loading = viewModel.loadingState {} else {
            XCTFail("Expected .loading state")
        }
    }
}
