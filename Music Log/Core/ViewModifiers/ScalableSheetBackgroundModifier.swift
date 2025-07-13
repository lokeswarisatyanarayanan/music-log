//
//  ScalableSheetBackgroundModifier.swift
//  Music Log
//
//  Created by Lokeswari on 05/07/25.
//


import SwiftUI

enum ScalableMetrics {
    static let scale: CGFloat = 0.95
    static let cornerRadius: CGFloat = 20
    static let topPadding: CGFloat = 12
    static let shadowRadius: CGFloat = 12
    static let shadowYOffset: CGFloat = 4
}

struct ScalableBackgroundView<Content: View>: View {
    let isActive: Bool
    let content: Content

    init(isActive: Bool, @ViewBuilder content: () -> Content) {
        self.isActive = isActive
        self.content = content()
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            content
                .cornerRadius(isActive ? ScalableMetrics.cornerRadius : 0)
                .scaleEffect(isActive ? ScalableMetrics.scale : 1.0)
                .padding(.top, isActive ? ScalableMetrics.topPadding : 0)
                .shadow(
                    color: .black.opacity(isActive ? 0.2 : 0),
                    radius: ScalableMetrics.shadowRadius,
                    x: 0,
                    y: ScalableMetrics.shadowYOffset
                )
                .animation(.spring(response: 0.4, dampingFraction: 0.85), value: isActive)

            if isActive {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .animation(.easeInOut, value: isActive)
            }
        }
    }
}
