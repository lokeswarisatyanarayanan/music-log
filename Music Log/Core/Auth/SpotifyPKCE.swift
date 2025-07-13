//
//  SpotifyPKCE.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import Foundation
import CryptoKit

struct SpotifyPKCE {
    let codeVerifier: String
    let codeChallenge: String

    init() {
        self.codeVerifier = SpotifyPKCE.generateCodeVerifier()
        self.codeChallenge = SpotifyPKCE.generateCodeChallenge(from: codeVerifier)
    }

    static func generateCodeVerifier() -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~"
        return String((0..<128).map { _ in characters.randomElement()! })
    }

    static func generateCodeChallenge(from verifier: String) -> String {
        let data = Data(verifier.utf8)
        let hash = SHA256.hash(data: data)
        return Data(hash)
            .base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}
