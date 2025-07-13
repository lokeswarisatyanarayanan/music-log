//
//  AppEnvironment.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import Foundation
import SwiftData
import Observation

@MainActor
@Observable
final class AppEnvironment {
    let homeViewModel: HomeViewModel
    let logViewModel: LogViewModel
    let profileViewModel: ProfileViewModel
    let authManager: SpotifyAuthManager
    let dataStore: SwiftDataStore

    init(
        homeViewModel: HomeViewModel,
        logViewModel: LogViewModel,
        profileViewModel: ProfileViewModel,
        authManager: SpotifyAuthManager,
        dataStore: SwiftDataStore
    ) {
        self.homeViewModel = homeViewModel
        self.logViewModel = logViewModel
        self.profileViewModel = profileViewModel
        self.authManager = authManager
        self.dataStore = dataStore
    }

    static func live(context: ModelContext) -> AppEnvironment {
        let tokenStore = SpotifyTokenStore()
        let authManager = SpotifyAuthManager(tokenStore: tokenStore)
        let tokenProvider: SpotifyTokenProvider = authManager
        let client = DefaultHTTPClient()

        let trackService = SpotifyTrackService(client: client, tokenProvider: tokenProvider)
        let userService = SpotifyUserService(client: client, tokenProvider: tokenProvider)
        let store = SwiftDataStore(context: context)
        let homeDataStore = HomeDataStore(store: store)

        return AppEnvironment(
            homeViewModel: .init(trackService: trackService, dataStore: homeDataStore),
            logViewModel: .init(dataStore: store),
            profileViewModel: .init(service: userService, tokenStore: tokenStore),
            authManager: authManager,
            dataStore: store
        )
    }
}
