//
//  RadioAppCleanSwiftUITests.swift
//  RadioAppCleanSwiftUITests
//
//  Created by Furkan ic on 23.07.2024.
//

import XCTest
@testable import RadioAppCleanSwiftUI

final class RadioAppCleanSwiftUITests: XCTestCase {
    
    var viewModel: MainViewModel?
    var mockStationsInteractor: MockStationsInteractor?
    var mockStationsDataForLocal: [Station] {
        [
            .init(name: "Radio 1", url: "https://radio1.com"),
            .init(name: "Radio 2", url: "https://radio2.com"),
            .init(name: "Radio 3", url: "https://radio3.com"),
        ]
    }
    
    var mockStationDataForWeb: [Station] {
        [
            .init(name: "Radio 4", url: "https://radio4.com"),
            .init(name: "Radio 5", url: "https://radio5.com"),
            .init(name: "Radio 6", url: "https://radio6.com"),
        ]
    }
    
    override func setUp() {
        viewModel = MainViewModel(
            stationsInteractor: MockStationsInteractor()
        )
    }

    override func tearDown() {
        viewModel = nil
    }

    func testGetRadioStationsSuccessfully() async throws {
        let expectedStations = mockStationsDataForLocal
        let localRepository = MockStationsEmbeddedRepository()
        localRepository.fetchStationsReturnValue = expectedStations
        let interactor = MockStationsInteractor(stationsEmbeddedFilesRepository: localRepository)
        viewModel = MainViewModel(stationsInteractor: interactor)
        
        await viewModel?.getRadioStations()
        
        XCTAssertEqual(viewModel?.stations, expectedStations)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
