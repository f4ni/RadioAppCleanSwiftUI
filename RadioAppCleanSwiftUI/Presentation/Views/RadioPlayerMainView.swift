//
//  RadioPlayerMainView.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 23.07.2024.
//

import SwiftUI

struct RadioPlayerMainView: View {
    
    @StateObject var viewModel = RadioPlayerViewModel(repository: RadioStationRepository())
    
    var body: some View {
        List(viewModel.stations) { station in
            Text(station.name ?? "")
        }
    }
}
