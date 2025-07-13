//
//  Track.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import Foundation

struct Track: Identifiable, Equatable {
    let id: String
    let title: String
    let artist: String
    let album: String?
    let albumType: String?
    let artworkURL: URL?
    let durationMs: Int?
    let playedAt: String?
    let deviceName: String?   
}
