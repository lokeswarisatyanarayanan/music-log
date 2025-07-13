//
//  Mood.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import Foundation

enum Mood: String, Codable, CaseIterable {
    case mellow
    case upbeat
    case moody
    case nostalgic
    case dreamlike
    case heavy
    case wired
    case none
    
    var emoji: String {
        switch self {
        case .mellow:     return "🪷"
        case .upbeat:     return "🪩"
        case .moody:      return "🪞"
        case .nostalgic:  return "🫧"
        case .dreamlike:  return "🪐"
        case .heavy:      return "🪨"
        case .wired:      return "🧿"
        case .none:       return "⬛️"  
        }
    }

    var label: String {
        switch self {
        case .mellow: return "Mellow"
        case .upbeat: return "Upbeat"
        case .moody: return "Moody"
        case .nostalgic: return "Nostalgic"
        case .dreamlike: return "Dream like"
        case .heavy: return "Heavy"
        case .wired: return "Wired"
        case .none: return "Nothing"
        }
    }
}
