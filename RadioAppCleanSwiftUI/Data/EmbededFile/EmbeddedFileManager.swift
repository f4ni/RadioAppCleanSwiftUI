//
//  EmbeddedFileManager.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 6.08.2024.
//

import Foundation

struct EmbeddedFileManager {
    func getDataFrom(file: String) throws -> Data {
        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
            print("failed to locate \(file) in bundle")
            throw NetworkError.invalidUrl
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("Failed to load \(file) from bundle")
            throw NetworkError.failedToLoad
        }
        
        return data
    }
}
