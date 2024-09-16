//
//  RadioStation.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 23.07.2024.
//

import Foundation

struct Station: Decodable, Identifiable, Hashable {
    static func == (lhs: Station, rhs: Station) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id = UUID()
    var name: String?
    var type: ChannelType?
    var castURL: String?
    var logo: String?
    var city: String?
    var frequence: String?
    var isPlaying: Bool? = false
    var webUrl: String?
    var background: String?
    var contact: [Contact]?
    
    public func update(
        name: String? = nil,
        type: ChannelType? = nil,
        castURL: String? = nil,
        logo: String? = nil,
        city: String? = nil,
        frequence: String? = nil,
        isPlaying: Bool? = nil,
        webUrl: String? = nil,
        background: String? = nil,
        contact: [Contact]? = nil
    ) -> Self {
        var self_ = self
        
        self_.name = name ?? self.name
        self_.type = type ?? self.type
        self_.castURL = castURL ?? self.castURL
        self_.logo = logo ?? self.logo
        self_.city = city ?? self.city
        self_.frequence = frequence ?? self.frequence
        self_.isPlaying = isPlaying ?? self.isPlaying
        self_.webUrl = webUrl ?? self.webUrl
        self_.background = background ?? self.background
        self_.contact = contact ?? self.contact
        
        return self_
    }
    
    mutating func play() {
        self.isPlaying = true
    }
    
    mutating func pause() {
        self.isPlaying = false
    }
}

enum ChannelType: String, Codable {
    case tv
    case radio
}
