//
//  WeatherViewModelTests.swift
//  WeatherAppTests
//
//  Created on 04/09/25.
//

import XCTest
@testable import WeatherApp

final class WeatherViewModelTests: XCTestCase {
    @MainActor
    func testLoadWeatherSuccess() async {
        let mockUseCase = MockGetWeatherUseCase()
        let condition = ConditionWeather(text: "Clear", icon: nil)
        let report = WeatherReport(
            city: "Sydney",
            region: "Wales",
            country: "Australia",
            localtime: "2025-09-04 08:00",
            current: CurrentWeather(
                temperatureC: 29.9,
                condition: condition,
                windSpeedKmph: 15,
                humidity: 70,
                cloudcover: 30,
                feelslikeC: 31,
                uvIndex: 6
            ),
            daily: []
        )
        mockUseCase.result = .success(report)
        
        let viewModel = WeatherViewModel(getWeatherUseCase: mockUseCase)
        
        await viewModel.loadWeather(days: 3)
        
        guard case .complete(let model?) = viewModel.loadingState else {
            XCTFail("Expected .complete state with model")
            return
        }
        XCTAssertEqual(model.location, "Sydney, Australia")
        XCTAssertEqual(viewModel.weather?.temperature, "29°C")
    }
    
    @MainActor
    func testLoadWeatherError() async {
        let mockUseCase = MockGetWeatherUseCase()
        mockUseCase.result = .failure(URLError(.notConnectedToInternet))
        
        let viewModel = WeatherViewModel(getWeatherUseCase: mockUseCase)
        await viewModel.loadWeather(days: 1)
        guard case .error(let message) = viewModel.loadingState else {
            XCTFail("Expected .error state")
            return
        }
        XCTAssertTrue(!message.isEmpty)

    }
    
    @MainActor
    func testInitialLoadingStateIsLoading() {
        let mockUseCase = MockGetWeatherUseCase()
        let viewModel = WeatherViewModel(getWeatherUseCase: mockUseCase)
        if case .loading = viewModel.loadingState {} else {
            XCTFail("Expected .loading state")
        }
    }
}
