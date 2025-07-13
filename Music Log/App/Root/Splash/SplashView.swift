//
//  SplashView.swift
//  Music Log
//
//  Created by Lokeswari on 07/07/25.
//

import SwiftUI
import UIKit
import Iconoir

struct SplashView: View {
    @Environment(\.theme) private var theme

    @State private var iconOffsetY: CGFloat = 0
    @State private var iconScaleY: CGFloat = 1.0
    @State private var iconScaleX: CGFloat = 1.0
    @State private var textOpacity: Double = 0

    var onFinish: () -> Void = {}

    var body: some View {
        ZStack {
            theme.background.ignoresSafeArea()

            VStack(spacing: Metrics.iconToTextSpacing) {
                Iconoir.musicNoteSolid.asImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: Metrics.iconSize, height: Metrics.iconSize)
                    .foregroundStyle(theme.primary)
                    .offset(y: iconOffsetY)
                    .scaleEffect(x: iconScaleX, y: iconScaleY)
                    .animation(.interpolatingSpring(stiffness: 220, damping: 16), value: iconOffsetY)

                Text("Music Log")
                    .textStyle(.title2, weight: .bold)
                    .foregroundStyle(theme.primary)
                    .scaleEffect(textOpacity == 1 ? 1.0 : 0.95)
                    .opacity(textOpacity)
                    .animation(.spring(response: 0.5, dampingFraction: 0.85), value: textOpacity)
            }
        }
        .task {
            await playIntroAnimation()
        }
    }

    private func playIntroAnimation() async {
        await MainActor.run {
            iconOffsetY = -Metrics.jumpOffset
            iconScaleY = Metrics.squashScale
            iconScaleX = Metrics.squashScale
        }

        try? await Task.sleep(nanoseconds: Metrics.jumpDuration)

        await MainActor.run {
            Haptics.shared.tap()
            withAnimation(.interactiveSpring()) {
                iconOffsetY = 0
                iconScaleY = 1.0
                iconScaleX = 1.0
                textOpacity = 1
            }
        }

        try? await Task.sleep(nanoseconds: Metrics.totalDuration)

        await MainActor.run {
            onFinish()
        }
    }
}

// MARK: - Metrics

private extension SplashView {
    enum Metrics {
        static let iconSize: CGFloat = 60
        static let iconToTextSpacing: CGFloat = 12

        static let jumpOffset: CGFloat = 30
        static let squashScale: CGFloat = 0.9

        static let jumpDuration: UInt64 = 300_000_000
        static let totalDuration: UInt64 = 800_000_000
    }
}

// MARK: - Haptics

final class Haptics {
    static let shared = Haptics()
    private let generator = UIImpactFeedbackGenerator(style: .light)

    func tap() {
        generator.prepare()
        generator.impactOccurred()
    }
}

