//
//  RadioPlayerMainView.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 23.07.2024.
//

import SwiftUI

struct RadioPlayerMainView: View {
    
    @Environment(\.network) private var network: NetworkMonitor
    @EnvironmentObject private var player: PlayerManager
    @StateObject private var viewModel = MainViewModel()
    @State private var navigationPath = NavigationPath()
    @State private var infoPagePresented = false
    @State private var stationToPresent: Station?
    @State private var showDetail = false
    
    @Namespace var namespace
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            container
                .background(backgroundView)
                .onAppear(perform: {
                    viewModel.getRadioStations()
                })
                .onReceive(player.$activeStation, perform: { value in
                    viewModel.activeStation = value
                })
                .toolbar(.visible, for: .navigationBar)
                .toolbar {
                    Button(action: {
                    infoPagePresented.toggle()
                    }, label: {
                        Image(systemName: "info.circle")
                    })
                }
                .navigationTitle("Good to Listen")
        }
        .sheet(isPresented: $infoPagePresented, content: {
            InfoPageView(content: InfoPageContent(about: "about"))
        })
        .navigationBarTitleDisplayMode(.large)
    }
}

extension RadioPlayerMainView {
    var container: some View {
        ZStack {
            if network.connected, !viewModel.stations.isEmpty {
                List(
                    viewModel.stations,
                    id: \.self,
                    selection: $stationToPresent
                ){ station in
                    let stationIsPlaying = viewModel.isPlaying(station: station)
                    ChannelListCell(
                        content: ChannelListCellContent(
                            station: station,
                            buttonLabel:
                                getPlayPauseButtonLabelImage(
                                    for: station
                                ),
                            isAwaiting: stationIsPlaying && player.timeControlStatus == .waitingToPlayAtSpecifiedRate
                        ),
                        namespace: namespace, playPauseButtonAction: {
                            stationIsPlaying
                            ? player.pause()
                            : player.play(station)
                        }
                    )
                    .listRowBackground(
                        Color.clear
                    )
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .listRowSpacing(6)
                .scrollContentBackground(.hidden)
                
                if let stationToPresent, showDetail {
                    StationDetailView(
                        showDetail: $showDetail,
                        station: stationToPresent,
                        namespace: namespace
                    )
                }

            } else {
                if viewModel.stations.isEmpty {
                    ContentUnavailableView("Station list couldn't load", systemImage: "exclamationmark.bubble")
                }
                if !network.connected {
                    ContentUnavailableView(
                        "No Network Connection",
                        systemImage: "wifi.exclamationmark",
                        description: Text(
                            "Check your connection"
                        )
                    )
                }
            }
        }
        .padding(0)
        .onChange(of: stationToPresent) {
            guard stationToPresent != nil else { return }
            withAnimation(.spring(.smooth, blendDuration: 0.3)) {
                showDetail.toggle()
            }
        }
        .onChange(of: showDetail) {
            guard !showDetail else { return }
            stationToPresent = nil
        }
    }
    
    
    func getPlayPauseButtonLabelImage(for station: Station) ->  Image {
        viewModel.isPlaying(station: station) && player.timeControlStatus != .waitingToPlayAtSpecifiedRate
        ? .pauseButton
        : .playButton
    }
}

extension RadioPlayerMainView {
    var backgroundView: some View {
        LinearGradient.oceanGradient
            .ignoresSafeArea(.all)
    }
}

#Preview {
    RadioPlayerMainView()
        .environmentObject(PlayerManager.shared)
}
