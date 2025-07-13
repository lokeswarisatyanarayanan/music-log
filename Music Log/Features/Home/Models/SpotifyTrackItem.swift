//
//  SpotifyTrackItem.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//


import Foundation

struct SpotifyTrackItem: Decodable {
    let id: String
    let name: String
    let artists: [SpotifyArtist]
    let album: SpotifyAlbum
    let duration_ms: Int
    let deviceName: String?
}
