//
//  View+Extension.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 17.08.2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, modifier: (Self) -> Content) -> some View {
        if condition {
            modifier(self)
        } else {
            self
        }
    }
}

extension View {
    @ViewBuilder
    func rotationAnimation(speed: Double = 5) -> some View {
        self.modifier(RotationAnimaton(speed: speed))
    }
}

extension View {
    public func blink() -> some View {
        modifier(BlinkViewModifier())
    }
}
