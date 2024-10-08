//
//  RadioAppCleanSwiftUIApp.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 23.07.2024.
//

import SwiftUI

@main
struct RadioAppCleanSwiftUIApp: App {
    @State private var networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            RadioPlayerMainView()
                .environmentObject(PlayerManager.shared)
                .environment(\.network, networkMonitor)
        }
    }
}
