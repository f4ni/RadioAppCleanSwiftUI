//
//  FileStorage.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 3.08.2024.
//

import Foundation

final class FileStorage {
    private let fileManager = FileManager.default
    private let directoryURL: URL
    
    init(directoryURL: FileManager.SearchPathDirectory) {
        self.directoryURL = fileManager.urls(for: directoryURL, in: .userDomainMask)[0]
    }
    
    func save(data: Data, to fileName: String) -> Bool {
        let fileURL = directoryURL.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            
            return true
        } catch {
            print("Failed to write data: \(error)")
            return false
        }
    }
    
    func load(from fileName: String) -> Data? {
        let fileURL = directoryURL.appendingPathComponent(fileName)
        
        do {
            return try Data(contentsOf: fileURL)
        } catch {
            print("Failed to read data: \(error)")
            return nil
        }
    }
}
