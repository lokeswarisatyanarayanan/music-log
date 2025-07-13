//
//  HomeDataStore.swift
//  Music Log
//
//  Created by Lokeswari on 08/07/25.
//

import Foundation
import SwiftData

protocol HomeDataStoreProtocol {
    func findOrCreateLoggedTrack(from track: Track) -> LoggedTrack
    func log(track: Track, mood: Mood, title: String, note: String)
}

final class HomeDataStore: HomeDataStoreProtocol {
    private let store: SwiftDataStoreProtocol

    init(store: SwiftDataStoreProtocol) {
        self.store = store
    }

    func findOrCreateLoggedTrack(from track: Track) -> LoggedTrack {
        let trackID = track.id
         
         let predicate = #Predicate<LoggedTrack> { loggedTrack in
             loggedTrack.trackID == trackID
         }

        if let existing = store.fetch(of: LoggedTrack.self, where: predicate).first {
            return existing
        } else {
            let new = LoggedTrack(track: track)
            store.insert(new)
            return new
        }
    }

    func log(track: Track, mood: Mood, title: String, note: String) {
        let loggedTrack = findOrCreateLoggedTrack(from: track)
        let moodNote = UserMoodNote(body: note)
        let log = TrackLog(track: loggedTrack, mood: mood, title: title, note: moodNote)
        loggedTrack.logs.append(log)
        store.insert(loggedTrack)
    }
}
