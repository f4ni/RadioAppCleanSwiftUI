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
        ZStack(alignment: .top) {
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
                            playPauseButtonAction(station)
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

                playerButtonsContainer
                
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
    
    private func playPauseButtonAction(_ station: Station) {
        (station.isPlaying ?? false)
        ? player.pause()
        : player.play(station)
    }
    
    func getPlayPauseButtonLabelImage(for station: Station? = nil) ->  Image {
        var status: Bool = player.isPLaying
        
        if let station {
            status = viewModel.isPlaying(station: station) && player.timeControlStatus != .waitingToPlayAtSpecifiedRate
        }
        
        return status ? .pauseButton : .playButton
    }
}

extension RadioPlayerMainView {
    var playerButtonsContainer: some View {
        ZStack {
            Color.clear.background(.thinMaterial)
                .clipShape(Capsule())
                .frame( maxHeight: .infinity, alignment: .bottom)
                .padding(.vertical, 18)
            HStack {
                Group {
                    Button(action: {}, label: {
                        Image.previousButton
                    })
                    Button(action: {
                        player.isPLaying ? player.pause() : player.play(viewModel.stations.first)
                    }, label: {
                        getPlayPauseButtonLabelImage()
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                            .padding(20)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    })
                    Button(action: {}, label: {
                        Image.nextButton
                    })
                }
                .foregroundStyle(LinearGradient.oceanGradient.blendMode(.multiply))
                .fontWeight(.bold)
                .frame(height: 30)
                .padding()
            }
            .layoutPriority(2)
            .padding()
            .clipShape(Capsule())
        }
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 3, y: 5)
        .fixedSize(horizontal: true, vertical: true)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .padding()
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
