//
//  APIEndpoints.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 2.08.2024.
//

import Foundation

var BASE_URL = ""

enum APIEndpoints {
    case getStationList(FetchRadioStationsRequest)
}

extension APIEndpoints: NetworkRequest {

    var commonHeaders: [String: String] {
        ["Conten-Type": "application/json"]
    }
    
    var baseUrl: URL {
        URL(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .getStationList:
            ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getStationList:
            .get
        }
    }
    
    var headers: [String : String]? {
        commonHeaders
    }
    
    var body: Encodable? {
        switch self {
        case .getStationList:
            nil
        }
    }
    
    var queryItems: Encodable? {
        switch self {
        case let .getStationList(queryModel):
            queryModel
        }
    }
}
