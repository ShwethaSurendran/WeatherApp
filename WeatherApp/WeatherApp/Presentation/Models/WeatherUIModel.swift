//
//  WeatherUIModel.swift
//  WeatherApp
//
//  Created on 03/09/25.
//

import Foundation

struct WeatherUIModel {
    let date: String
    let location: String
    let conditionIcon: URL?
    let condition: String
    let temperature: String
    let daily: [DailyWeatherUIModel]
    let weatherDetails: [WeatherDetailsUIModel]
}

struct DailyWeatherUIModel {
    let date: String
    let temperatureRange: String
    let conditionIcon: URL?
}

struct WeatherDetailsUIModel {
    let name: String
    let value: String
}
