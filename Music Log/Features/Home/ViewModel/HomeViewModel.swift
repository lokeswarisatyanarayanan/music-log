//
//  HomeViewModel.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import Foundation
import Observation

@Observable
@MainActor
final class HomeViewModel {
    
    private let trackService: SpotifyTrackServiceProtocol
    private let dataStore: HomeDataStoreProtocol

    var nowPlayingTrack: Track?
    var recentlyPlayedTracks: [Track] = []
    var isLoading: Bool = false
    var errorMessage: String?

    init(trackService: SpotifyTrackServiceProtocol, dataStore: HomeDataStoreProtocol) {
        self.trackService = trackService
        self.dataStore = dataStore
    }
    
    func load() async {
        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            async let nowPlaying = trackService.currentTrack()
            async let recent = trackService.recentlyPlayed()

            self.nowPlayingTrack = try await nowPlaying
            self.recentlyPlayedTracks = try await recent
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func log(track: Track, mood: Mood, title: String, note: String) {
        dataStore.log(track: track, mood: mood, title: title, note: note)
    }
}
