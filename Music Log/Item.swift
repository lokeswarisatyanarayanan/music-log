//
//  Item.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
