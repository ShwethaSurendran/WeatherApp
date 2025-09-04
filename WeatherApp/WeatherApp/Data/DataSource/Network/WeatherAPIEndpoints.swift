//
//  WeatherAPIEndpoints.swift
//  WeatherApp
//
//  Created on 03/09/25.
//

import Foundation

enum WeatherAPIEndpoints {
    static func weather(city: String, days: Int = 7) -> URLRequest? {
        var components = URLComponents(string: "\(APIConfig.baseURL)/forecast.json")
        components?.queryItems = [
            URLQueryItem(name: "key", value: APIConfig.apiKey),
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "days", value: "\(days)")
        ]
        guard let url = components?.url else {
            return nil
        }
        return URLRequest(url: url)
    }
}

