//
//  PersistenceController.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import SwiftData

final class PersistenceController {
    static let shared = PersistenceController()

    let container: ModelContainer

    init(inMemory: Bool = false) {
        let schema = Schema([LoggedTrack.self, UserMoodNote.self]) 
        let config = ModelConfiguration(
            "MusicLog",
            schema: schema,
            isStoredInMemoryOnly: inMemory
        )

        container = try! ModelContainer(for: schema, configurations: [config])
    }
}
