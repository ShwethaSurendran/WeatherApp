//
//  WeatherView.swift
//  WeatherApp
//
//  Created on 04/09/25.
//

import SwiftUI

struct WeatherView: View {
    
    @State var cityName: String = ""
    @StateObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.9), Color.green.opacity(0.6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                switch weatherViewModel.loadingState {
                case .loading: ProgressView()
                case .error(_) :
                    Text(AppStrings.UI.errorMessage)
                        .multilineTextAlignment(.center)
                        .padding()
                        .accessibilityIdentifier(AppStrings.AccessibilityIds.errorMessageView)
                case .complete(let weatherModel):
                    ScrollView {
                        CurrentWeatherInfoView(weather: weatherModel)
                        DailyWeatherForecastView(daily: weatherModel?.daily ?? [])
                        WeatherDetailsView(weatherDetails: weatherModel?.weatherDetails ?? [])
                    }
                    .padding(.top, 20)
                    .accessibilityIdentifier(AppStrings.AccessibilityIds.scrollView)
                }
            }
            .searchable(text: $cityName, prompt: AppStrings.UI.searchCityPrompt)
            .onSubmit(of: .search) {
                Task {
                    await weatherViewModel.loadWeather(city: cityName)
                }
            }
        }
        .task {
            await weatherViewModel.loadWeather()
        }
        .tint(.white)
    }
}

struct WeatherDetailsView: View {
    var weatherDetails: [WeatherDetailsUIModel]
    
    var body: some View {
        VStack(spacing: 15) {
            VStack {
                ForEach(weatherDetails, id: \.name) { item in
                    WeatherDetailRow(label: item.name, value: item.value)
                }
            }
            .padding()
        }
        .padding(.horizontal, 30)
        .padding(.top, 20)
    }
}


#Preview {
    WeatherView(weatherViewModel: .init(getWeatherUseCase: GetWeatherUseCase(repository: WeatherRepositoryImpl(dataSource: WeatherAPIService()))))
}
