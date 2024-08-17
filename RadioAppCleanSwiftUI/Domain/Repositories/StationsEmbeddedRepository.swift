//
//  StationsEmbeddedRepository.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 23.07.2024.
//

import Combine

protocol StationsEmbeddedRepositoryInterface {
    func fetchStations() throws -> [Station]
}

struct StationsEmbeddedRepository: StationsEmbeddedRepositoryInterface {
    func fetchStations() throws -> [Station] {
        try EmbeddedFileClient().parseData(with: .stations)
    }
}
