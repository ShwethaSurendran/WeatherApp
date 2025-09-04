//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created on 03/09/25.
//

import Foundation
import Observation

@Observable
final class SearchViewModel: ObservableObject {
    var cities: [SearchUIModel] = []
    var loadingState: LoadingState<[SearchUIModel]> = .loading
    var searchText: String = ""
    
    private let getSearchUseCase: SearchUseCaseProtocol

    init(getSearchUseCase: SearchUseCaseProtocol) {
        self.getSearchUseCase = getSearchUseCase
    }

    @MainActor
    func loadCities() async {
        loadingState = .loading

        do {
            let citiesList = try await getSearchUseCase.getCities(city: searchText)
            self.cities = citiesList.map({$0.toUI()})
            loadingState = .complete(self.cities)
        } catch {
            self.loadingState = .error(error.localizedDescription)
        }
    }
    
    @MainActor
    func clean() {
        cities.removeAll()
        searchText = ""
    }
}

