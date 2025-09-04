//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created on 03/09/25.
//

import Foundation

enum LoadingState {
    case loading
    case complete(WeatherUIModel?)
    case error(String)
}

final class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherUIModel?
    @Published var loadingState: LoadingState = .loading

    private let getWeatherUseCase: GetWeatherUseCaseProtocol

    init(getWeatherUseCase: GetWeatherUseCaseProtocol) {
        self.getWeatherUseCase = getWeatherUseCase
    }

    @MainActor
    func loadWeather(city: String="Melbourne", days: Int=4) async {
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

