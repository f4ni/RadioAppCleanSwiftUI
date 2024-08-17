//
//  StationsWebRepository.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 2.08.2024.
//

import Foundation

protocol StationsWebRepositoryInterface {
    func fetchStations(genre: String?, country: String?) async throws -> [Station]
}

struct StationsWebRepository: StationsWebRepositoryInterface {
    func fetchStations(genre: String? = nil, country: String? = nil) async throws -> [Station] {
        try await NetworkClient().send(APIEndpoints.getStationList(FetchRadioStationsRequest(genre: genre, country: country)))
    }
}
