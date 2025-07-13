//
//  Tab.swift
//  Music Log
//
//  Created by Lokeswari on 04/07/25.
//

import Iconoir

enum Tab: CaseIterable {
    case home, log, profile

    var title: String {
        switch self {
        case .home: return "Home"
        case .log: return "Log"
        case .profile: return "Profile"
        }
    }

    var icon: Iconoir {
        switch self {
        case .home: return .hotAirBalloon
        case .log: return .bookStack
        case .profile: return .userLove
        }
    }
}
