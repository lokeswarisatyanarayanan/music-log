//
//  String+Extension.swift
//  Music Log
//
//  Created by Lokeswari on 13/07/25.
//
import Foundation

extension String {
    func toSpotifyDate() -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: self)
    }
    
    func relativeTimeString() -> String {
        guard let date = self.toSpotifyDate() else { return "Unknown time" }
        return date.relativeTimeString()
    }
}
