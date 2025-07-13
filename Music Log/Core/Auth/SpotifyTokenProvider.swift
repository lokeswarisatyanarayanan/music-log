//
//  SpotifyTokenProvider.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//


import Foundation

protocol SpotifyTokenProvider {
    func token() async throws -> String
}
