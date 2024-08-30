//
//  InfoPageView.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 19.08.2024.
//

import SwiftUI

struct InfoPageView: View {
    var content: InfoPageContent
    
    var body: some View {
        VStack {
            Text(content.about)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient.oceanGradient.ignoresSafeArea(.all))
    }
}

struct InfoPageContent: Hashable {
    var about: String
}
