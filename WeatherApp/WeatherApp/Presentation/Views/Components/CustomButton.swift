//
//  CustomButton.swift
//  WeatherApp
//
//  Created on 04/09/25.
//

import SwiftUI

struct CustomButton: View {
    let title: String
    let iconName: String
    @Binding var isTapped: Bool
    
    var body: some View {
        Button(action: {
            isTapped.toggle()
        }) {
            HStack(spacing: 10) {
                Text(title)
                Image(systemName: iconName)
            }
            .foregroundColor(.white)
            .padding(10)
            .background(.black.opacity(0.1))
            .cornerRadius(10)
            .frame(width: 150, height: 60)
        }
        .accessibilityIdentifier("CustomButton")
    }
}
