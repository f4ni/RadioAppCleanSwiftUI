//
//  StationContact.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 23.07.2024.
//

import Foundation

// MARK: - Contact
struct Contact: Codable, Identifiable {
    var id: UUID?
    var name: ContactChannelName?
    var target: String?
}

enum ContactChannelName: String, Codable{
    case telephone
    case whatsapp
    case telegram
    case youtube
    case instagram
    case web
}
