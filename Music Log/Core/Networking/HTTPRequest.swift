//
//  HTTPRequest.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//


import Foundation

public struct HTTPRequest {
    public let path: String
    public var method: String = "GET"
    public var headers: [String: String] = [:]
    public var query: [String: String] = [:]

    public var urlRequest: URLRequest {
        var components = URLComponents(string: path)!
        components.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        var request = URLRequest(url: components.url!)
        request.httpMethod = method
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }

    public init(path: String) {
        self.path = path
    }
}
