//
//  SpotifyAuthManager.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import Foundation
import AuthenticationServices
import UIKit

final class SpotifyAuthManager: NSObject, ASWebAuthenticationPresentationContextProviding, SpotifyTokenProvider {
    private let tokenStore: SpotifyTokenStore
    private var currentPKCE: SpotifyPKCE?
    private var tokenTask: Task<String, Error>?
    private var isAuthenticating = false

    init(tokenStore: SpotifyTokenStore) {
        self.tokenStore = tokenStore
    }

    func token() async throws -> String {
        // Check if we already have a valid token
        if let token = tokenStore.accessToken, tokenStore.isAccessTokenValid {
            return token
        }
        
        if let existing = tokenTask {
            return try await existing.value
        }

        // Create a new task for token retrieval
        let task = Task { () throws -> String in
            defer {
                tokenTask = nil
                isAuthenticating = false
            }
            
            // Double-check token validity inside the task
            if let token = tokenStore.accessToken, tokenStore.isAccessTokenValid {
                return token
            }
            
            // Try to refresh token first
            if let refresh = tokenStore.refreshToken {
                do {
                    try await refreshAccessToken(refresh)
                    if let token = tokenStore.accessToken, tokenStore.isAccessTokenValid {
                        return token
                    }
                } catch {
                    // Log the error but continue to full authentication
                    print("Token refresh failed: \(error)")
                }
            }
            
            // Perform full authentication flow
            return try await performAuthenticationFlow()
        }

        tokenTask = task
        return try await task.value
    }

    func authenticate() async throws {
        // Prevent multiple simultaneous authentication attempts
        guard !isAuthenticating else {
            throw MusicLogError.authenticationInProgress
        }
        
        isAuthenticating = true
        defer { isAuthenticating = false }
        
        let pkce = SpotifyPKCE()
        currentPKCE = pkce
        let state = UUID().uuidString

        guard let url = SpotifyAuthEndpoints.authorizationURL(codeChallenge: pkce.codeChallenge, state: state) else {
            throw MusicLogError.invalidAuthURL
        }

        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            let session = ASWebAuthenticationSession(url: url, callbackURLScheme: "musiclog") { callbackURL, error in
                if let error = error {
                    // Handle user cancellation gracefully
                    if case ASWebAuthenticationSessionError.canceledLogin = error {
                        continuation.resume(throwing: MusicLogError.authFailed)
                    } else {
                        continuation.resume(throwing: error)
                    }
                    return
                }

                guard
                    let url = callbackURL,
                    let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                    let code = components.queryItems?.first(where: { $0.name == "code" })?.value
                else {
                    continuation.resume(throwing: MusicLogError.invalidCallback)
                    return
                }

                Task {
                    do {
                        try await self.exchangeCodeForToken(code)
                        continuation.resume()
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }

            session.presentationContextProvider = self
            session.prefersEphemeralWebBrowserSession = true
            session.start()
        }
    }

    private func performAuthenticationFlow() async throws -> String {
        try await authenticate()
        guard let token = tokenStore.accessToken, tokenStore.isAccessTokenValid else {
            throw MusicLogError.authFailed
        }
        return token
    }

    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        UIApplication.shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow } ?? UIWindow()
    }
}

extension SpotifyAuthManager {
    func exchangeCodeForToken(_ code: String) async throws {
        guard let verifier = currentPKCE?.codeVerifier else {
            throw MusicLogError.missingCodeVerifier
        }

        var request = URLRequest(url: URL(string: SpotifyAuthEndpoints.tokenURL)!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let params = [
            "client_id": SpotifyAuthEndpoints.clientID,
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": SpotifyAuthEndpoints.redirectURI,
            "code_verifier": verifier
        ]

        request.httpBody = params
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .data(using: .utf8)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw MusicLogError.tokenExchangeFailed
        }
        
        guard httpResponse.statusCode == 200 else {
            throw MusicLogError.tokenExchangeFailed
        }

        let tokenResponse = try JSONDecoder().decode(SpotifyTokenResponse.self, from: data)

        tokenStore.save(
            accessToken: tokenResponse.access_token,
            refreshToken: tokenResponse.refresh_token,
            expiresIn: tokenResponse.expires_in
        )
    }

    func refreshAccessToken(_ refreshToken: String) async throws {
        var request = URLRequest(url: URL(string: SpotifyAuthEndpoints.tokenURL)!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let params = [
            "client_id": SpotifyAuthEndpoints.clientID,
            "grant_type": "refresh_token",
            "refresh_token": refreshToken
        ]

        request.httpBody = params
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .data(using: .utf8)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw MusicLogError.refreshTokenRevoked
        }
        
        guard httpResponse.statusCode == 200 else {
            throw MusicLogError.refreshTokenRevoked
        }

        let tokenResponse = try JSONDecoder().decode(SpotifyTokenResponse.self, from: data)

        tokenStore.save(
            accessToken: tokenResponse.access_token,
            refreshToken: tokenResponse.refresh_token ?? refreshToken,
            expiresIn: tokenResponse.expires_in
        )
    }
}
