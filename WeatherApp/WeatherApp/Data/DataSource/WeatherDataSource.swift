//
//  WeatherDataSource.swift
//  WeatherApp
//
//


protocol WeatherDataSource {
    func fetchWeather(city: String, days: Int) async throws -> WeatherResponse
}
