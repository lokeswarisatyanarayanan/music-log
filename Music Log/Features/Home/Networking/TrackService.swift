//
//  TrackService.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import Foundation

protocol SpotifyTrackServiceProtocol {
    func currentTrack() async throws -> Track?
    func recentlyPlayed() async throws -> [Track]
}

final class SpotifyTrackService: SpotifyTrackServiceProtocol {
    private let client: HTTPClient
    private let tokenProvider: SpotifyTokenProvider
    
    init(client: HTTPClient, tokenProvider: SpotifyTokenProvider) {
        self.client = client
        self.tokenProvider = tokenProvider
    }
    
    func currentTrack() async throws -> Track? {
        let token = try await tokenProvider.token()
        var request = HTTPRequest(path: "https://api.spotify.com/v1/me/player/currently-playing")
        request.headers["Authorization"] = "Bearer \(token)"
        
        let response: SpotifyCurrentlyPlayingResponse? = try await client.send(request)
        
        if let item = response?.item {
            return Track(
                id: item.id,
                title: item.name,
                artist: item.artists.first?.name ?? "Unknown",
                album: item.album.name,
                albumType: item.album.album_type,
                artworkURL: URL(string: item.album.images.first?.url ?? ""),
                durationMs: item.duration_ms,
                playedAt: nil,
                deviceName: item.deviceName
            )
        }
        return nil
    }
    
    
    func recentlyPlayed() async throws -> [Track] {
        let token = try await tokenProvider.token()
        var request = HTTPRequest(path: "https://api.spotify.com/v1/me/player/recently-played")
        request.headers["Authorization"] = "Bearer \(token)"
        
        let response: SpotifyRecentlyPlayedResponse = try await client.send(request)
        
        return response.items
            .uniqued { $0.track.id }
            .map {
                Track(
                    id: $0.track.id,
                    title: $0.track.name,
                    artist: $0.track.artists.first?.name ?? "Unknown",
                    album: $0.track.album.name,
                    albumType: $0.track.album.album_type,
                    artworkURL: URL(string: $0.track.album.images.first?.url ?? ""),
                    durationMs: $0.track.duration_ms,
                    playedAt: $0.played_at,
                    deviceName: nil
                )
            }
    }
}
