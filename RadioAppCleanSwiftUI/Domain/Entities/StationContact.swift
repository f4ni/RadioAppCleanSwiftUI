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
    var type: ContactType?
    var target: String?
}

enum ContactType: String, Codable{
    case telephone
    case whatsapp
    case telegram
    case youtube
    case instagram
    case web
    
    static var toFollow: [Self] {
        [.instagram, .youtube]
    }
    
    static var toContract: [Self] {
        [.telephone, .whatsapp, .telegram]
    }
}
