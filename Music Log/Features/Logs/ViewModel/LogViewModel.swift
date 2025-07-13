//
//  LogViewModel.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import Foundation
import Observation

@MainActor
@Observable
final class LogViewModel {
    private let dataStore: SwiftDataStore

    var logs: [LoggedTrack] = []

    init(dataStore: SwiftDataStore) {
        self.dataStore = dataStore
        load()
    }

    func load() {
        logs = dataStore.fetch(of: LoggedTrack.self)
    }

    func delete(_ log: LoggedTrack) {
        dataStore.delete(log)
        load()
    }
}
