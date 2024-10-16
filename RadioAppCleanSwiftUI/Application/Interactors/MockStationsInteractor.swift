//
//  MockStationsInteractor.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 16.10.2024.
//


final class MockStationsInteractor: StationsInteractorInterface {

    private let stationsWebRepository: StationsWebRepositoryInterface
    private let stationsEmbeddedFilesRepository: StationsEmbeddedRepositoryInterface
    
    init(
        stationsWebRepository: StationsWebRepositoryInterface = MockStationsWebRepository(),
        stationsEmbeddedFilesRepository: StationsEmbeddedRepositoryInterface = MockStationsEmbeddedRepository()
    ) {
        self.stationsWebRepository = stationsWebRepository
        self.stationsEmbeddedFilesRepository = stationsEmbeddedFilesRepository
    }
    
    func fetchStations(genre: String? = nil, country: String? = nil) async throws -> [Station] {
        return try stationsEmbeddedFilesRepository.fetchStations()
    }
}