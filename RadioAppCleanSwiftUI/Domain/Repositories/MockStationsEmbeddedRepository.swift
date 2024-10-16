//
//  MockStationsEmbeddedRepository.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 16.10.2024.
//



class MockStationsEmbeddedRepository: StationsEmbeddedRepositoryInterface {
    
    var fetchStationsCalled = false
    var fetchStationsReturnValue: [Station] = []
    
    func fetchStations() throws -> [Station] {
        fetchStationsCalled = true
        return fetchStationsReturnValue
    }
}