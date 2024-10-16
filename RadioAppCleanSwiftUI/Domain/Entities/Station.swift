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
    var url: String?
    var logo: String?
    var city: String?
    var frequence: String?
    var isPlaying: Bool? = false
    var webUrl: String?
    var background: String?
    var contact: [Contact]?
    
    var filteredContact: [Contact]? {
        contact?.filter({ c in
            SocialNetworkType.toContract.contains(where: {$0 == c.type})
        })
    }
    
    var toFollow: [Contact]? {
        contact?.filter({ c in
            SocialNetworkType.toFollow.contains(where: {$0 == c.type})
        })
    }
    
    init(
        name: String? = nil,
        type: ChannelType? = nil,
        url: String? = nil,
        logo: String? = nil,
        city: String? = nil,
        frequence: String? = nil,
        isPlaying: Bool? = nil,
        webUrl: String? = nil,
        background: String? = nil,
        contact: [Contact]? = nil
    ) {
        self.name = name
        self.type = type
        self.url = url
        self.logo = logo
        self.city = city
        self.frequence = frequence
        self.isPlaying = isPlaying
        self.webUrl = webUrl
        self.background = background
        self.contact = contact
    }
    
    mutating func update(
        name: String? = nil,
        type: ChannelType? = nil,
        url: String? = nil,
        logo: String? = nil,
        city: String? = nil,
        frequence: String? = nil,
        isPlaying: Bool? = nil,
        webUrl: String? = nil,
        background: String? = nil,
        contact: [Contact]? = nil
    ) -> Self {
        
        self.name = name ?? self.name
        self.type = type ?? self.type
        self.url = url ?? self.url
        self.logo = logo ?? self.logo
        self.city = city ?? self.city
        self.frequence = frequence ?? self.frequence
        self.isPlaying = isPlaying ?? self.isPlaying
        self.webUrl = webUrl ?? self.webUrl
        self.background = background ?? self.background
        self.contact = contact ?? self.contact
        
        return self
    }
    
    mutating func play() {
        self.isPlaying = true
    }
    
    mutating func pause() {
        self.isPlaying = false
    }
    
    mutating func setPlayingStatus(to isPlaying: Bool) {
        self.isPlaying = isPlaying
    }
}

enum ChannelType: String, Codable {
    case tv
    case radio
}
