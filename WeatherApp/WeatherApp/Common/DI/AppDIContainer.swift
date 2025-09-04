//
//  AppDIContainer.swift
//  WeatherApp
//
//  Created on 04/09/25.
//

import Foundation

final class AppDIContainer {
    @MainActor static let shared = AppDIContainer()

    // MARK: - Weather
    private lazy var weatherAPIService: WeatherDataSource = {
        WeatherAPIService()
    }()

    private lazy var weatherRepository: WeatherRepository = {
        WeatherRepositoryImpl(dataSource: weatherAPIService)
    }()

    private lazy var getWeatherUseCase: GetWeatherUseCaseProtocol = {
        GetWeatherUseCase(repository: weatherRepository)
    }()

    lazy var weatherViewModel: WeatherViewModel = {
        WeatherViewModel(getWeatherUseCase: getWeatherUseCase)
    }()

    // MARK: - Search
    private lazy var searchAPIService: SearchDataSource = {
        SearchAPIService()
    }()

    private lazy var searchRepository: SearchRepository = {
        SearchRepositoryImpl(dataSource: searchAPIService)
    }()

    private lazy var searchUseCase: SearchUseCaseProtocol = {
        SearchUseCase(repository: searchRepository)
    }()

    lazy var searchViewModel: SearchViewModel = {
        SearchViewModel(getSearchUseCase: searchUseCase)
    }()
    
}
