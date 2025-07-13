//
//  ScaleEffectOnTap.swift
//  Music Log
//
//  Created by Lokeswari on 13/07/25.
//

import SwiftUI

extension View {
    func scaleEffectOnTap() -> some View {
        self.modifier(ScaleEffectOnTap())
    }
}

struct ScaleEffectOnTap: ViewModifier {
    @State private var isPressed = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed ? 0.97 : 1.0)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in withAnimation(.easeInOut(duration: 0.1)) { isPressed = true } }
                    .onEnded { _ in withAnimation(.easeOut(duration: 0.15)) { isPressed = false } }
            )
    }
}
