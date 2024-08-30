//
//  ViewModifier+RotationAnimaton.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 30.08.2024.
//

import SwiftUI

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
