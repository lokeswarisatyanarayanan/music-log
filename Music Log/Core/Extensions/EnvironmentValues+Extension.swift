//
//  EnvironmentValues+Extension.swift
//  Music Log
//
//  Created by Lokeswari on 04/07/25.
//
import SwiftUI

extension EnvironmentValues {
    var env: AppEnvironment {
        get { self[EnvironmentKeyApp.self] }
        set { self[EnvironmentKeyApp.self] = newValue }
    }
    
    var theme: AppTheme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}
