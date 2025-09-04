//
//  WeatherReport+UIMapper.swift
//  WeatherApp
//
//  Created on 03/09/25.
//

import Foundation

extension SearchModel {
    func toUI() -> SearchUIModel {
        .init(name: name, id: id, country: country)
    }
}
