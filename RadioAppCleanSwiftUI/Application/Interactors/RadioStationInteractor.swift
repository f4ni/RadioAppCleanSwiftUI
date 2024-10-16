//
//  RadioStationInteractor.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 23.07.2024.
//

import Combine

protocol StationsInteractorInterface: AnyObject {
    func fetchStations(genre: String?, country: String?) async throws -> [Station]
}

final class StationsInteractor: StationsInteractorInterface {
    private let stationsWebRepository: StationsWebRepositoryInterface
    private let stationsEmbeddedFilesRepository: StationsEmbeddedRepositoryInterface
    
    init(
        stationsWebRepository: StationsWebRepositoryInterface = StationsWebRepository(),
        stationsEmbeddedFilesRepository: StationsEmbeddedRepositoryInterface = StationsEmbeddedRepository()
    ) {
        self.stationsWebRepository = stationsWebRepository
        self.stationsEmbeddedFilesRepository = stationsEmbeddedFilesRepository
    }
    
    func fetchStations(genre: String? = nil, country: String? = nil) async throws -> [Station] {
//        try await stationsWebRepository.fetchStations(genre: genre, country: country)
        return try stationsEmbeddedFilesRepository.fetchStations()
    }
}
