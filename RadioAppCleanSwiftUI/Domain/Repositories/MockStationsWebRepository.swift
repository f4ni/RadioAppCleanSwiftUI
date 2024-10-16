//
//  MockStationsWebRepository.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 16.10.2024.
//


final class MockStationsWebRepository: StationsWebRepositoryInterface {
    
    var fetchStationsCalled: Bool = false
    var fetchStationsResult: [Station] = []
    
    func fetchStations(genre: String? = nil, country: String? = nil) async throws -> [Station] {
        fetchStationsCalled = true
        return fetchStationsResult
    }
}

