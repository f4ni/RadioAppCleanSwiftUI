//
//  EmbeddedFileDataModel.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 6.08.2024.
//

import Foundation

enum EmbeddedFileDataModel {
    case stations
}

extension EmbeddedFileDataModel {

    var fileName: String {
        switch self {
        case .stations:
            "stations.json"
        }
    }
    
    var dataModel: Decodable.Type {
        switch self {
        case .stations:
            [Station].self
        }
    }
}
