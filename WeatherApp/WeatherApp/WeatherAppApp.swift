//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created on 03/09/25.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    
    private let diContainer = AppDIContainer()
    
    var body: some Scene {
        WindowGroup {
            WeatherView(weatherViewModel: diContainer.weatherViewModel)
        }
    }
}
