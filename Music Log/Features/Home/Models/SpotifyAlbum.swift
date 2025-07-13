//
//  SpotifyAlbum.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//


struct SpotifyAlbum: Decodable {
    let name: String
    let album_type: String
    let release_date: String?
    let images: [SpotifyImage]
}
