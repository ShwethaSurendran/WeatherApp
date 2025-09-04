//
//  APIClient.swift
//  WeatherApp
//
//  Created on 03/09/25.
//

import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: URLRequest) async throws -> T
}

final class APIClient: APIClientProtocol {
    func request<T: Decodable>(_ endpoint: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: endpoint)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
