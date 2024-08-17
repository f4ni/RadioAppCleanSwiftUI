//
//  EmbeddedFileClient.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 6.08.2024.
//

import Foundation

struct EmbeddedFileClient {
    func parseData<T: Decodable>(with model: EmbeddedFileDataModel) throws -> T {
        let data = try EmbeddedFileManager().getDataFrom(file: model.fileName)
        guard let typedModel = model.dataModel as? T.Type else {
            throw NetworkError.decodingFailed(nil)
        }
        return try Decode().decode(typedModel, from: data)
    }
}
