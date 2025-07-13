//
//  ShimmerModifier.swift
//  Music Log
//
//  Created by Lokeswari on 05/07/25.
//

import SwiftUI

struct ShimmerModifier: ViewModifier {
    @State private var width: CGFloat = 0
    @Environment(\.theme) private var theme

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in

                    LinearGradient(
                        gradient: Gradient(colors: [theme.surfaceBackground, theme.surfaceBackground.opacity(0.2), theme.surfaceBackground]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: width, height: geometry.size.height)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: false)) {
                            width = geometry.size.width + 4
                        }
                    }
                    .mask(content)
                }
            )
    }
}


extension View {
    func shimmer() -> some View {
        self.modifier(ShimmerModifier())
    }
}

