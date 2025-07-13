//
//  MusicLogError.swift
//  Music Log
//
//  Created by Lokeswari on 04/07/25.
//

import Foundation

enum MusicLogError: Error, LocalizedError {
    case refreshTokenRevoked
    case authFailed
    case invalidAuthURL
    case invalidCallback
    case tokenExchangeFailed
    case missingCodeVerifier
    case authenticationInProgress

    var errorDescription: String? {
        switch self {
        case .refreshTokenRevoked:
            return "Your session has expired. Please sign in again."
        case .authFailed:
            return "Authentication failed. Please try again."
        case .invalidAuthURL:
            return "Couldn't generate a valid login URL."
        case .invalidCallback:
            return "Login response was invalid or corrupted."
        case .tokenExchangeFailed:
            return "Failed to retrieve access token from Spotify."
        case .missingCodeVerifier:
            return "Security verifier was missing during login flow."
        case .authenticationInProgress:
            return "Authentication is in progress. Please wait."
        }
    }

    var failureReason: String? {
        switch self {
        case .refreshTokenRevoked:
            return "The refresh token is no longer valid."
        case .authFailed:
            return "The authentication process didn't return a valid token."
        case .invalidAuthURL:
            return "The app wasn't able to create a login request to Spotify."
        case .invalidCallback:
            return "Returned login info didn't include the required parameters."
        case .tokenExchangeFailed:
            return "Spotify returned an error while attempting token exchange."
        case .missingCodeVerifier:
            return "The PKCE verifier was lost during the login session."
        case .authenticationInProgress:
            return "It looks like you're already being authenticated."
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .refreshTokenRevoked, .authFailed:
            return "Try signing out and logging back in."
        case .invalidAuthURL, .invalidCallback, .missingCodeVerifier:
            return "Try restarting the app."
        case .tokenExchangeFailed:
            return "Try again after some time."
        case .authenticationInProgress:
            return "Please wait a moment and try again."
        }
    }

    var title: String {
        switch self {
        case .refreshTokenRevoked: return "Session Expired"
        case .authFailed: return "Login Failed"
        case .invalidAuthURL: return "URL Error"
        case .invalidCallback: return "Login Error"
        case .tokenExchangeFailed: return "Token Error"
        case .missingCodeVerifier: return "Internal Error"
        case .authenticationInProgress: return "Authentication In Progress"
        }
    }
}
