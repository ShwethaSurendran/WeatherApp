//
//  WeatherReport+UIMapper.swift
//  WeatherApp
//
//  Created on 03/09/25.
//

import Foundation

extension WeatherReport {
    func toUI() -> WeatherUIModel {
        
        let date = self.localtime.convertDateFormat(fromFormat: DateFormat.yearMonthDayTime, toFormat: DateFormat.weekdayDayMonthYear) ?? ""
        let location = city + ", " + country
        
        return WeatherUIModel(
            date: date,
            location: location,
            conditionIcon: current.condition.icon,
            condition: current.condition.text,
            temperature: "\(Int(current.temperatureC))°C",
            daily: daily.map {
                let formattedDate = $0.date.convertDateFormat(fromFormat: DateFormat.yearMonthDay, toFormat: DateFormat.weekdayShort) ?? ""
                return DailyWeatherUIModel(
                    date: formattedDate,
                    temperatureRange: "\(Int($0.minTempC))° - \(Int($0.maxTempC))°",
                    conditionIcon: $0.condition.icon
                )
            },
            weatherDetails: [
                .init(name: "Wind", value: "\(Int(current.windSpeedKmph)) km/h"),
                .init(name: "Humidity", value: "\(Int(current.humidity))%"),
                .init(name: "Cloud cover", value: "\(Int(current.cloudcover))"),
                .init(name: "Feels Like", value: "\(Int(current.feelslikeC))°"),
                .init(name: "UV Index", value: "\(Int(current.uvIndex))")
            ]
        )
    }
}
