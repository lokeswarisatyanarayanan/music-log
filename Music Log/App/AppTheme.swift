//
//  AppTheme.swift
//  Music Log
//
//  Created by Lokeswari on 04/07/25.
//


import SwiftUI

struct AppTheme {
    let primary = Color("PrimaryAppColor")
    let secondary = Color("SecondaryAppColor")
    let background = Color("BackgroundColor")
    let surfaceBackground = Color("SurfaceColor")
    let card = Color("CardColor")
    let textPrimary = Color("TextPrimary")
    let textInverse = Color("TextInverse")
    let textSecondary = Color("TextSecondary")
    let tint = Color("TintColor")
}

struct ThemeKey: EnvironmentKey {
    static let defaultValue = AppTheme()
}
