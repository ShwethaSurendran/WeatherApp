//
//  AppStrings.swift
//  WeatherApp
//
//  Created on 03/09/25.
//

import Foundation

struct AppStrings {
    struct UI {
        static let searchCityPrompt = "Enter city name"
        static let errorMessage = "Oops! \n Unable to get weather information. Make sure the city name is correct or check your network connection."
    }
    
    struct AccessibilityIds {
        static let errorMessageView = "errorMessage"
        static let scrollView = "containerScrollView"
    }
}
