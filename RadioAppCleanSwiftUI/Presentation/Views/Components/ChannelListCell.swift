//
//  ChannelListCell.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 16.08.2024.
//

import SwiftUI

struct ChannelListCell: View {
    
    var content: ChannelListCellContent
    var playPauseButtonAction: () -> Void
    }
    
    var body: some View {
        HStack {
            content.logo
                .resizable(capInsets: EdgeInsets())
                .aspectRatio(contentMode: .fit)
                .frame(width: 50.0, height: 50.0)
                .scaledToFit()
                .mask(Rectangle())
            Text(content.name)
            
            Spacer()
            Button {
                playPauseButtonAction()
            } label: {
                content.buttonLabel
                .resizable()
                .frame(width: 44, height: 44)
                .if(content.isAwaiting) { view in
                    view
                    .rotationAnimation(speed: 360)
                }
            }
            .buttonStyle(.borderless)
        }
        .padding()
        .background(background)
    }
}

extension ChannelListCell {
    var background: some View {
        Color.clear.background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 16)
        )
    }
}
