//
//  ChannelListCellContent.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 16.08.2024.
//

import SwiftUI

struct ChannelListCollapsedCellContent: Identifiable {
    var id = UUID()
    var name: String
    var logo: Image
    var buttonLabel: Image
    var isPlaying: Bool
    
    init(
        station: Station,
        buttonLabel: Image,
        isPlaying: Bool = false
    ) {
        self.id = station.id
        self.name = station.name ?? ""
        self.logo = station.image
        self.buttonLabel = buttonLabel
        self.isPlaying = isPlaying
    }
}

extension ChannelListCollapsedCellContent {
    static var dummy: Self {
        Self(station: Station(name: "Bla Radio Station", logo: "rehbertv 1"), buttonLabel: Image.playButton)
    }
}
