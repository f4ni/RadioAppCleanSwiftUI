//
//  LinearGradient+extension.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 18.08.2024.
//

import SwiftUI

extension LinearGradient {
    static var earthyGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.green,
                    Color.green.opacity(0.5)
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    static var pastelGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.pink.opacity(0.3),
                    Color.blue.opacity(0.3)
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    static var sunsetGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(
                colors: [
                    Color.orange,
                    Color.red,
                    Color.purple
                ]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    static var oceanGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.teal, Color.blue]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    static var monochromeGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [Color.black, Color.white]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
