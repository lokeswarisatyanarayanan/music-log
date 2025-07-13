//
//  SpotifyAuthEndpoints.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import Foundation

enum SpotifyAuthEndpoints {
    static let clientID = ""
    static let redirectURI = ""
    static let authorizeURL = "https://accounts.spotify.com/authorize"
    static let tokenURL = "https://accounts.spotify.com/api/token"

    static let scopes: [String] = [
        "user-read-playback-state",
        "user-read-currently-playing",
        "user-read-recently-played",
        "user-read-email",
        "user-read-private"
    ]

    static func authorizationURL(codeChallenge: String, state: String) -> URL? {
        var components = URLComponents(string: authorizeURL)
        components?.queryItems = [
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "redirect_uri", value: redirectURI),
            URLQueryItem(name: "scope", value: scopes.joined(separator: " ")),
            URLQueryItem(name: "code_challenge_method", value: "S256"),
            URLQueryItem(name: "code_challenge", value: codeChallenge),
            URLQueryItem(name: "state", value: state),
            URLQueryItem(name: "show_dialog", value: "true")
        ]
        return components?.url
    }
}
