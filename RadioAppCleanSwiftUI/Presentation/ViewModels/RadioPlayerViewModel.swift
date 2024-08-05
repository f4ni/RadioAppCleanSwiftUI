//
//  ViewModel.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 23.07.2024.
//

import Foundation

final class RadioPlayerViewModel: ObservableObject {
    
    var repository: RadioStationRepositoryInterface
    
    @Published var stations: [Station] = []
    
    init(repository: RadioStationRepositoryInterface) {
        self.repository = repository
    }
    
    func getRadioStations() {
        Task {
            let radioStations = try await repository.fetchStations(genre: nil, country: nil)
        }
    }
}
