//
//  WeatherView.swift
//  WeatherApp
//
//  Created on 04/09/25.
//

import SwiftUI

struct WeatherView: View {
    @State var weatherViewModel: WeatherViewModel
    @State private var showCitySearchView: Bool = false
    
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
                    VStack {
                        HStack {
                            Spacer()
                            CustomButton(title: AppStrings.UI.searchButtonTitle, iconName: "magnifyingglass", isTapped: $showCitySearchView)
                        }
                        Spacer()
                        Text(AppStrings.UI.errorMessage)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .accessibilityIdentifier(AppStrings.AccessibilityIds.errorMessageView)
                        Spacer()
                    }
                case .complete(let weatherModel):
                    VStack {
                        
                        HStack {
                            Spacer()
                            CustomButton(title: AppStrings.UI.searchButtonTitle, iconName: "magnifyingglass", isTapped: $showCitySearchView)
                        }
                        
                        ScrollView {
                            CurrentWeatherInfoView(weather: weatherModel)
                            DailyWeatherForecastView(daily: weatherModel?.daily ?? [])
                            WeatherDetailsView(weatherDetails: weatherModel?.weatherDetails ?? [])
                        }
                        .padding(.top, 20)
                        .accessibilityIdentifier(AppStrings.AccessibilityIds.scrollView)
                    }
                }
            }
            .sheet(isPresented: $showCitySearchView) {
                CitySearchView(selectedCity: $weatherViewModel.city, isPresented: $showCitySearchView, viewModel: AppDIContainer.shared.searchViewModel)
                    .presentationDetents([.fraction(0.99)])
            }
        }
        .task {
            await weatherViewModel.loadWeather()
        }
        
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
