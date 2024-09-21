//
//  SocialNetworkType.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 21.09.2024.
//

import Foundation

enum SocialNetworkType: String, Codable{
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
    
    var getURLPrefix: String? {
        switch self {
        case .telephone:
            "tel://"
        case .whatsapp:
            "https://wa.me/"
        case .telegram:
            "https://t.me/"
        case .youtube:
            "https://www.youtube.com/@"
        case .instagram:
            "https://www.instagram.com/"
        case .web:
            ""
        }
    }
}
