//
//  Station+image.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 16.08.2024.
//

import SwiftUI

extension Station {
    var image: Image {
        guard let logo, UIImage(named: logo) != nil
        else {
            return Image(systemName: "dot.radiowaves.left.and.right")
        }
        return Image(logo)
    }
}
