//
//  AppDIContainer.swift
//  WeatherApp
//
//  Created on 04/09/25.
//

import Foundation

final class AppDIContainer {
    
    // MARK: - Data Layer
    private lazy var weatherAPIService: WeatherDataSource = {
        WeatherAPIService()
    }()
    
    private lazy var weatherRepository: WeatherRepository = {
        WeatherRepositoryImpl(dataSource: weatherAPIService)
    }()
    
    // MARK: - Domain Layer
    private lazy var getWeatherUseCase: GetWeatherUseCaseProtocol = {
        GetWeatherUseCase(repository: weatherRepository)
    }()
    
    // MARK: - Presentation Layer
    lazy var weatherViewModel: WeatherViewModel = {
        WeatherViewModel(getWeatherUseCase: getWeatherUseCase)
    }()
    
}
