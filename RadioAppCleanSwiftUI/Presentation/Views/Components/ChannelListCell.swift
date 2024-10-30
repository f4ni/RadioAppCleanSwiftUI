//
//  ChannelListCell.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 16.08.2024.
//

import SwiftUI

struct ChannelListCell: View {

    @Namespace var namespace
    var station: Station?
    @Binding var expandedStation: Station?
    var awaitingToLoad: Bool
    var isPlaying: Bool
    var playPauseButtonAction: () -> Void
    var isExpanded: Bool {
        expandedStation == station
    }
    
    var body: some View {
        
        ZStack {
     
            if let station {
                if isExpanded {
                    StationListCellExpanded(namespace: namespace, station: station) {
                        collapseCell()
                    }
                } else {
                    StationListCellCollapsed(
                        awaitingToLoad: awaitingToLoad,
                        namespace: namespace,
                        content: .init(
                            station: station,
                            buttonLabel: getPlayPauseButtonLabelImage()
                        )
                    ) {
                        playPauseButtonAction()
                    }
                    .onTapGesture {
                        expandCell()
                    }
                }
            }
        }
    }

    private func expandCell() {
        withAnimation {
            expandedStation = station
        }
        debugPrint("expand")
    }
    
    private func collapseCell() {
        withAnimation {
            expandedStation = nil
        }
        debugPrint("collapse")
    }

    private func getPlayPauseButtonLabelImage() -> Image {
        isPlaying ? .pauseButton : .playButton
    }
}

#Preview {
    @Previewable @State var st2: Station? = Station(name: "chnl2")
    @Previewable @State var isPlaying: Bool = false
    @Previewable @State var awaitingToLoad: Bool = false
    @Previewable @Namespace var namespace
    let st1 = Station(name: "chnl1")
    
    VStack {
        ChannelListCell(
            namespace: _namespace,
            station: st1,
            expandedStation: $st2,
            awaitingToLoad: awaitingToLoad,
            isPlaying: isPlaying,
            playPauseButtonAction: {

                if isPlaying {
                    isPlaying.toggle()
                } else {
                    awaitingToLoad.toggle()
                    Task {
                        try await Task.sleep(nanoseconds: 3_000_000_000)
                        isPlaying = true
                        awaitingToLoad.toggle()
                    }
                }
            }
        )
        .padding()
    }
}
