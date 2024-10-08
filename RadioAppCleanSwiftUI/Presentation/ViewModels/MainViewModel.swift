//
//  ViewModel.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 23.07.2024.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    

    var stationsInteractor: StationsInteractorInterface
    
    @Published var stations: [Station] = []
    @Published var activeStation: Station?
    @Published var expandedStation: Station?

    init(
        stationsInteractor: StationsInteractorInterface = StationsInteractor(),
        activeStation: Station? = nil
    ) {
        self.stationsInteractor = stationsInteractor
        self.activeStation = activeStation
    }
    
    @MainActor
    func getRadioStations() {
        Task {
            stations = try await stationsInteractor.fetchStations(genre: nil, country: nil)
        }
    }
    
    func isPlaying( station: Station? = nil) -> Bool {
        station == activeStation
    }
}
