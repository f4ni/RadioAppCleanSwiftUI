//
//  BlinkViewModifier.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 20.10.2024.
//

import SwiftUICore

struct BlinkViewModifier: ViewModifier {
    @State var blinking = false
    func body(content: Content) -> some View {
        content
            .opacity(blinking ? 0.3: 1)
            .animation(.easeOut(duration: 0.5).repeatForever(), value: blinking)
            .onAppear {
                blinking.toggle()
            }
    }
}
