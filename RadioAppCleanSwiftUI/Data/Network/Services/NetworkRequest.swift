//
//  NetworkRequest.swift
//  RadioAppCleanSwiftUI
//
//  Created by Furkan ic on 31.07.2024.
//

import Foundation

protocol NetworkRequest {
    
    var baseUrl: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Encodable? { get }
    var queryItems: Encodable? { get }
    
    func urlRequest() throws -> URLRequest
}

extension NetworkRequest {
    
    func url() throws -> URL {
        guard var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)
        else {
            throw NetworkError.invalidUrl
        }
        
        var queryItemsDictionary = try queryItems?.toDictionary() ?? [:]
        components.path = path
        components.queryItems = queryItemsDictionary.map({ URLQueryItem(name: $0.key, value: "\($0.value)")})
        
        guard let url = components.url else { throw NetworkError.invalidUrl }
        
        return url
    }
    
    func urlRequest() throws -> URLRequest {
        let url = try url()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        let bodyParameters = try body?.toDictionary() ?? [:]
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters)

        return urlRequest
    }
}


private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String: Any]
    }
}
