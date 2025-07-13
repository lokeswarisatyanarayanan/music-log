//
//  SpotifyCurrentlyPlayingResponse.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import Foundation

protocol EmptyDecodable: Decodable {
    static var empty: Self { get }
}

struct SpotifyCurrentlyPlayingResponse: EmptyDecodable {
    let item: SpotifyTrackItem?

    static var empty: SpotifyCurrentlyPlayingResponse {
        SpotifyCurrentlyPlayingResponse(item: nil)
    }

    private enum CodingKeys: String, CodingKey {
        case item
    }
}
