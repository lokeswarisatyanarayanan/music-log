//
//  TabButton.swift
//  Music Log
//
//  Created by Lokeswari on 04/07/25.
//


import SwiftUI
import Iconoir

struct TabButton: View {
    let tab: Tab
    let tabWidth: CGFloat
    let isSelected: Bool
    let onTap: () -> Void
    
    @Environment(\.theme) private var theme

    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                onTap()
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
        }) {
            HStack(spacing: 6) {
                tab.icon.asImage
                    .font(.system(size: isSelected ? 22 : 20, weight: .medium))
                    .foregroundStyle(iconColor)

                if isSelected {
                    Text(tab.title)
                        .textStyle(.caption, weight: .semibold)
                        .foregroundStyle(iconColor)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
            .frame(width: tabWidth, height: 40)
            .contentShape(Rectangle())
        }
    }

    private var iconColor: Color {
        isSelected ? theme.textPrimary : theme.textSecondary
    }
}
