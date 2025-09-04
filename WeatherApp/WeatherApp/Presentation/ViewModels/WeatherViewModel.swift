//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created on 03/09/25.
//

import Foundation

enum LoadingState<T> {
    case loading
    case complete(T?)
    case error(String)
}

@Observable
final class WeatherViewModel {
    var weather: WeatherUIModel?
    var loadingState: LoadingState<WeatherUIModel> = .loading
    var city: String = Constants.defaultCity
    {
        didSet {
            Task {
                await loadWeather()
            }
        }
    }

    private let getWeatherUseCase: GetWeatherUseCaseProtocol

    init(getWeatherUseCase: GetWeatherUseCaseProtocol) {
        self.getWeatherUseCase = getWeatherUseCase
    }

    @MainActor
    func loadWeather(days: Int=Constants.defaultForecastCount) async {
        loadingState = .loading

        do {
            let report = try await getWeatherUseCase.getWeather(city: city, days: days)
            self.weather = report.toUI()
            loadingState = .complete(self.weather)
        } catch {
            self.loadingState = .error(error.localizedDescription)
        }
    }
}

