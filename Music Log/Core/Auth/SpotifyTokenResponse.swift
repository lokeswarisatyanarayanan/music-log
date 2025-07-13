//
//  SpotifyTokenResponse.swift
//  Music Log
//
//  Created by Lokeswari on 04/07/25.
//


struct SpotifyTokenResponse: Decodable {
    let access_token: String
    let token_type: String
    let expires_in: Double
    let refresh_token: String?
    let scope: String
}