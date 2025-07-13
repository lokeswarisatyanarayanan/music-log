//
//  HTTPClient.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//


import Foundation

protocol HTTPClient: Sendable {
    func send<T: Decodable>(_ request: HTTPRequest) async throws -> T
}

struct DefaultHTTPClient: HTTPClient {
    func send<T: Decodable>(_ request: HTTPRequest) async throws -> T {
        let urlRequest = request.urlRequest
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        do {
            if data.isEmpty {
                if let emptyType = T.self as? EmptyDecodable.Type,
                   let emptyValue = emptyType.empty as? T {
                    return emptyValue
                } else {
                    throw URLError(.zeroByteResource)
                }
            }
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw error
        }
    }
}
