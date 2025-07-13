//
//  SpotifyRecentlyPlayedResponse.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import Foundation

struct SpotifyRecentlyPlayedResponse: Decodable {
    let items: [PlayedItem]
}

struct PlayedItem: Decodable {
    let track: TrackData
    let played_at: String?
}

struct TrackData: Decodable {
    let id: String
    let name: String
    let artists: [SpotifyArtist]
    let album: SpotifyAlbum
    let duration_ms: Int
}
