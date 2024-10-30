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
                   StationListCellCollapsed(namespace: namespace, content: .init(station: station, buttonLabel: Image.playButton)) {

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

    private func getPlayPauseButtonLabelImage(for station: Station? = nil) ->  Image {
        (station?.isPlaying ?? false) ? .pauseButton : .playButton
    }
}

#Preview {
    @Namespace var namespace
    let st1 = Station(name: "chnl1")
    @State var st2: Station? = Station(name: "chnl2")
    
    return VStack {
        ChannelListCell(
            namespace: _namespace,
            station: st1,
            expandedStation: $st2,
            playPauseButtonAction: {}
        )
        .padding()
    }
}
