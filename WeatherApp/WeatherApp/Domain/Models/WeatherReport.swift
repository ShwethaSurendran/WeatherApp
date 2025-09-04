//
//  WeatherReport.swift
//  WeatherApp
//
//  Created on 03/09/25.
//

import Foundation

struct WeatherReport {
    let city: String
    let region: String
    let country: String
    let localtime: String
    let current: CurrentWeather
    let daily: [DailyWeather]
}

struct CurrentWeather {
    let temperatureC: Double
    let condition: ConditionWeather
    let windSpeedKmph: Double
    let humidity: Double
    let cloudcover: Double
    let feelslikeC: Double
    let uvIndex: Double
}

struct ConditionWeather {
    let text: String
    let icon: URL?
}

struct DailyWeather {
    let date: String
    let maxTempC: Double
    let minTempC: Double
    let condition: ConditionWeather
}
