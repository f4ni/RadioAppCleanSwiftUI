//
//  StationContact.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 23.07.2024.
//

import Foundation

// MARK: - Contact
struct Contact: Codable, Identifiable {
    let id = UUID()
    var type: SocialNetworkType?
    var target: String?
    
    var url: URL? {
        guard let target else { return nil }
        
        guard let urlprefix = type?.getURLPrefix, let url = URL(string: urlprefix + target) else { return nil }
        
        return url
    }
}
