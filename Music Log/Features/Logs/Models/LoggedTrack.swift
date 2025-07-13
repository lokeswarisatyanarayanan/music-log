//
//  LoggedTrack.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import Foundation
import SwiftData

@Model
final class LoggedTrack {
    @Attribute(.unique) var id: UUID
    var trackID: String
    var title: String
    var artist: String
    var artworkURL: URL?
    var album: String?
    var duration: Int?

    @Relationship(deleteRule: .cascade, inverse: \TrackLog.track)
    var logs: [TrackLog] = []

    init(track: Track) {
        self.id = UUID()
        self.trackID = track.id
        self.title = track.title
        self.artist = track.artist
        self.artworkURL = track.artworkURL
        self.album = track.album
        self.duration = track.durationMs
    }
}

@Model
final class TrackLog {
    @Attribute(.unique) var id: UUID
    var date: Date
    var mood: Mood
    var title: String

    @Relationship(deleteRule: .nullify)
    var track: LoggedTrack

    @Relationship(deleteRule: .cascade)
    var note: UserMoodNote

    init(track: LoggedTrack, mood: Mood, title: String, note: UserMoodNote) {
        self.id = UUID()
        self.track = track
        self.date = Date()
        self.mood = mood
        self.title = title
        self.note = note
    }
}

@Model
final class UserMoodNote {
    @Attribute(.unique) var id: UUID
    var body: String
    var timestamp: Date

    init(body: String) {
        self.id = UUID()
        self.body = body
        self.timestamp = Date()
    }
}
