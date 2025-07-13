//
//  ProfileViewModel.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import Foundation
import Observation

@Observable
final class ProfileViewModel {
    private let service: SpotifyUserService
    private let tokenStore: SpotifyTokenStore

    var user: SpotifyUser?
    var isLoading = false
    var errorMessage: String?

    init(service: SpotifyUserService, tokenStore: SpotifyTokenStore) {
        self.service = service
        self.tokenStore = tokenStore
    }

    func loadProfile() async {
        isLoading = true
        defer { isLoading = false }

        do {
            user = try await service.fetchProfile()
        } catch {
            errorMessage = "Failed to load profile"
        }
    }
    
    var totalTracks: Int {
        // Connect to datastore or return mock
        42
    }

    var totalLogs: Int {
        18
    }

    func disconnect() {
        tokenStore.clear()
        user = nil
    }
}
