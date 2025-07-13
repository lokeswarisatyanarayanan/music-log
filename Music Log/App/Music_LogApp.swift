//
//  Music_LogApp.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import SwiftUI
import SwiftData
import UIKit

@main
struct MusicLogApp: App {

    @State private var isSplashFinished = false

    init() {
        let largeFont = UIFont(name: "Montserrat-Bold", size: 34)!
        let inlineFont = UIFont(name: "Montserrat-SemiBold", size: 17)!

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "BackgroundColor") ?? UIColor(red: 22/255, green: 27/255, blue: 34/255, alpha: 1.0)
        appearance.shadowColor = .clear
        appearance.largeTitleTextAttributes = [
            .font: largeFont,
            .foregroundColor: UIColor.label
        ]
        appearance.titleTextAttributes = [
            .font: inlineFont,
            .foregroundColor: UIColor.label
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some Scene {
        WindowGroup {
            if isSplashFinished {
                RootView()
                    .environment(\.theme, ThemeKey.defaultValue)
            } else {
                SplashView {
                    withAnimation(.interactiveSpring()) {
                        isSplashFinished = true
                    }
                }
                .environment(\.theme, ThemeKey.defaultValue)
            }
        }
        .modelContainer(PersistenceController.shared.container)
    }
}
