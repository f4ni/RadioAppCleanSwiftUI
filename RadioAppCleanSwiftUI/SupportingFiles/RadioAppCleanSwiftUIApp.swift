//
//  RadioAppCleanSwiftUIApp.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 23.07.2024.
//

import SwiftUI

@main
struct RadioAppCleanSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            RadioPlayerMainView()
                .environmentObject(PlayerManager.shared)
        }
        .environmentObject(PlayerManager.shared)
    }
}
