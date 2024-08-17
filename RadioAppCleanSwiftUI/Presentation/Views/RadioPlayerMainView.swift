//
//  RadioPlayerMainView.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 23.07.2024.
//

import SwiftUI

struct RadioPlayerMainView: View {
    
    @EnvironmentObject var player: PlayerManager
    @StateObject var viewModel = ViewModel()
    @State var alert = false
    
    var body: some View {
        container
        .onAppear(perform: {
            viewModel.getRadioStations()
        })
        .onReceive(player.$activeStation, perform: { value in
            viewModel.activeStation = value
        })
        .alert(isPresented: $alert, content: {
            Alert(title: Text("Alert Test"))
        })
    }
}

#Preview {
    RadioPlayerMainView()
        .environmentObject(PlayerManager.shared)
}

extension RadioPlayerMainView {
    var container: some View {
        List(viewModel.stations, id: \.id){ station in
            let stationIsPlaying = viewModel.isPlaying(station: station)
            ChannelListCell(
                content: ChannelListCellContent(
                    name: station.name ?? "",
                    logo: station.image,
                    buttonLabel:
                        getPlayPauseButtonLabelImage(
                            for: station
                        ),
                    isAwaiting: stationIsPlaying && player.timeControlStatus == .waitingToPlayAtSpecifiedRate
                ),
                playPauseButtonAction: {
                    stationIsPlaying
                    ? player.pause()
                    : player.play(station)
                }
            )
        }
    }
    
    
    func getPlayPauseButtonLabelImage(for station: Station) ->  Image {
        viewModel.isPlaying(station: station) && player.timeControlStatus != .waitingToPlayAtSpecifiedRate
        ? .pauseButton
        : .playButton
    }
}
