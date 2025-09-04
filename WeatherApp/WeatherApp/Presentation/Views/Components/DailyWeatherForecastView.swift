//
//  DailyWeatherForecastView.swift
//  WeatherApp
//
//  Created on 04/09/25.
//

import SwiftUI

struct DailyWeatherForecastView: View {
    
    var daily: [DailyWeatherUIModel]
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(daily, id: \.date) { item in
                VStack(spacing: 5) {
                    AsyncImage(url: item.conditionIcon) { image in
                        image.resizable()
                            .frame(width: 40, height: 40)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(item.date)
                    Text(item.temperatureRange)
                        .foregroundColor(.white.opacity(0.9))
                }
                .foregroundColor(.white)
                .font(.caption)
                .padding(12)
            }
        }
        .background(.black.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
