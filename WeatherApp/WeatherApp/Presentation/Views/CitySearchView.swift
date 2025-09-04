//
//  CitySearchView.swift
//  WeatherApp
//
//  Created on 04/09/25.
//

import SwiftUI

struct CitySearchView: View {
    @Binding var selectedCity: String
    @Binding var isPresented: Bool
    @State var viewModel: SearchViewModel
    
    var body: some View {
        NavigationStack {
            
            List(viewModel.cities, id: \.id) { city in
                Button(city.name+", "+city.country) {
                    isPresented = false
                    selectedCity = city.name
                    viewModel.clean()
                }
                .accessibilityIdentifier(city.name)
            }
            .navigationTitle(AppStrings.UI.selectCityPlaceholder)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchText, prompt: AppStrings.UI.searchBarPlaceholder)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(AppStrings.UI.cancelButtonTitle) {
                        viewModel.clean()
                        isPresented = false
                    }
                }
            }
            .onSubmit(of: .search) {
                Task {
                    await viewModel.loadCities()
                }
            }
        }
    }
}
