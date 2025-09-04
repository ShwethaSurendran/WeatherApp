//
//  WeatherResponse+Mapper.swift
//  WeatherApp
//
//  Created on 03/09/25.
//

import Foundation

extension SearchResponse {
    func toDomain() -> SearchModel {
        return SearchModel(name: name, id: id, country: country)
    }
}

