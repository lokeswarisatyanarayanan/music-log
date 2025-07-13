//
//  SpotifyUserService.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import Foundation

struct SpotifyUserService {
    private let client: HTTPClient
    private let tokenProvider: SpotifyTokenProvider

    init(client: HTTPClient, tokenProvider: SpotifyTokenProvider) {
        self.client = client
        self.tokenProvider = tokenProvider
    }
    
    func fetchProfile() async throws -> SpotifyUser {
        let token = try await tokenProvider.token()

        var request = HTTPRequest(path: "https://api.spotify.com/v1/me")
        request.headers["Authorization"] = "Bearer \(token)"

        let response: SpotifyUser = try await client.send(request)
        return response
    }
}
