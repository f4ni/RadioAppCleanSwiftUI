//
//  ChannelListCellContent.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 16.08.2024.
//

import SwiftUI

struct ChannelListCellContent: Identifiable {
    var id = UUID()
    var name: String
    var logo: Image
    var buttonLabel: Image
    var isAwaiting: Bool
    
    init(
        id: UUID = UUID(),
        name: String,
        logo: Image,
        buttonLabel: Image,
        isAwaiting: Bool = false
    ) {
        self.id = id
        self.name = name
        self.logo = logo
        self.buttonLabel = buttonLabel
        self.isAwaiting = isAwaiting
    }
}

extension ChannelListCellContent {
    static var dummy: Self {
        Self(name: "Bla Radio Station", logo: Image("cagrifm.png"), buttonLabel: Image.playButton)
    }
}
