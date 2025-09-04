//
//  WeatherDataSource.swift
//  WeatherApp
//
//


protocol SearchDataSource {
    func fetchCities(city: String) async throws -> [SearchResponse]
}
