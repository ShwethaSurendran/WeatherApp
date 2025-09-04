//
//  WeatherDetailRow.swift
//  WeatherApp
//
//  Created on 04/09/25.
//

import SwiftUI

struct WeatherDetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack {
            HStack {
                Text(label)
                Spacer()
                Text(value)
            }
            .font(.headline)
            .foregroundColor(.white.opacity(0.8))
            .padding(.vertical, 4)
            Divider()
        }
    }
}
