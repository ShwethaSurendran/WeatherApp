//
//  WeatherResponse.swift
//  WeatherApp
//
//

import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

// MARK: - Location
struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let localtime: String
}

// MARK: - Current Weather
struct Current: Codable {
    let temp_c: Double
    let condition: Condition
    let wind_kph: Double
    let humidity: Double
    let cloud: Double
    let feelslike_c: Double
    let uv: Double
}

// MARK: - Condition
struct Condition: Codable {
    let text: String
    let icon: String
    
    var iconURL: URL? {
        return URL(string: "https:\(icon)")
    }
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

// MARK: - ForecastDay
struct ForecastDay: Codable {
    let date: String
    let day: Day
}

// MARK: - Day
struct Day: Codable {
    let maxtemp_c: Double
    let mintemp_c: Double
    let condition: Condition
}
