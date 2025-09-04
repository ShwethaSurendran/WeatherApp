//
//  WeatherResponse+Mapper.swift
//  WeatherApp
//
//  Created on 03/09/25.
//

import Foundation

extension WeatherResponse {
    func toDomain() -> WeatherReport {
        return WeatherReport(
            city: location.name,
            region: location.region,
            country: location.country,
            localtime: location.localtime,
            current: CurrentWeather(
                temperatureC: current.temp_c,
                condition: ConditionWeather(
                    text: current.condition.text,
                    icon: current.condition.iconURL
                ),
                windSpeedKmph: current.wind_kph,
                humidity: current.humidity,
                cloudcover: current.cloud,
                feelslikeC: current.feelslike_c,
                uvIndex: current.uv
            ),
            daily: forecast.forecastday.map { forecast in
                DailyWeather(
                    date: forecast.date,
                    maxTempC: forecast.day.maxtemp_c,
                    minTempC: forecast.day.mintemp_c,
                    condition: ConditionWeather(
                        text: forecast.day.condition.text,
                        icon: forecast.day.condition.iconURL
                    )
                )
            }
        )
    }
}

