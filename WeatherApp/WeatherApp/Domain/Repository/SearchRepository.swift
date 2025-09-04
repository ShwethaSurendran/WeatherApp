//
//  WeatherRepository.swift
//  WeatherApp
//
//

import Foundation

protocol SearchRepository {
    func getCities(city: String) async throws -> [SearchModel]
}
