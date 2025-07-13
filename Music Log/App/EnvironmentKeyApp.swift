//
//  EnvironmentKeyApp.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import SwiftUI

struct EnvironmentKeyApp: EnvironmentKey {
    static var defaultValue: AppEnvironment {
        fatalError("❌ AppEnvironment not set in Environment")
    }
}
