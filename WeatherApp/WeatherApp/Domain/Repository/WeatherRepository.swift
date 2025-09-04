//
//  WeatherRepository.swift
//  WeatherApp
//
//

import Foundation

protocol WeatherRepository {
    func getWeather(city: String, days: Int) async throws -> WeatherReport
}
