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
    
    init(content: ChannelListCellContent, playPauseButtonAction: @escaping () -> Void) {
        self.content = content
        self.playPauseButtonAction = playPauseButtonAction
//        _isAwaiting = State(wrappedValue: content.isAwaiting)
        debugPrint("content ->")
        debugPrint(content)
    }
    
    var body: some View {
            HStack {
                content.logo
                    .resizable(capInsets: EdgeInsets())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50.0, height: 50.0)
                    .scaledToFit()
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
    }
}

#Preview {
    ChannelListCell(content: ChannelListCellContent.dummy) {
        
    }
}

extension View {
    @ViewBuilder
    func rotationAnimation(speed: Double = 5) -> some View {
        self.modifier(RotationAnimaton(speed: speed))
    }
}

struct RotationAnimaton: ViewModifier {
    @State private var rotation: Double = 0
    
    let speed: Double
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(rotation))
            .onAppear {
                startAnimation()
            }
            .animation(
                .interpolatingSpring(
                    stiffness: 30,
                    damping: 1
                ),
                value: rotation
            )
    }
    
    func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                rotation += speed
        }
    }
}
