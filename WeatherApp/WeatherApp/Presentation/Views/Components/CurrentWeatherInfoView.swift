//
//  CurrentWeatherInfoView.swift
//  WeatherApp
//
//  Created on 04/09/25.
//

import SwiftUI

struct CurrentWeatherInfoView: View {
    let weather: WeatherUIModel?
    
    var body: some View {
        VStack(spacing: 5) {
            Text(weather?.date ?? "")
                .font(.title2)
                .foregroundColor(.white.opacity(0.9))
            Text(weather?.location ?? "")
                .font(.title)
                .bold()
                
            AsyncImage(url: weather?.conditionIcon) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
            }
            
            Text(weather?.condition ?? "")
                .font(.headline)
                .foregroundColor(.white.opacity(0.9))
            Text(weather?.temperature ?? "")
                .font(.system(size: 70, weight: .thin))
        }
        .foregroundColor(.white)
    }
}
