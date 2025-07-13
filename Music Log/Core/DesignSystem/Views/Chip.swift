//
//  Chip.swift
//  Music Log
//
//  Created by Lokeswari on 05/07/25.
//

import SwiftUI

struct Chip: View {
    let label: String
    let isSelected: Bool
    let emoji: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Constants.spacing) {
                Text(emoji)
                Text(label)
                    .textStyle(.caption, weight: .semibold)
                    .lineLimit(1)
                    .layoutPriority(1)
            }
            .padding(.horizontal, Constants.horizontalPadding)
            .padding(.vertical, Constants.verticalPadding)
            .frame(maxWidth: .infinity)
            .background(isSelected ? theme.primary.opacity(0.2) : theme.surfaceBackground)
            .foregroundStyle(isSelected ? theme.primary : theme.textPrimary)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(isSelected ? theme.primary : .clear, lineWidth: Constants.strokeWidth)
            )
            .contentShape(Rectangle())
        }
    }
    
    @Environment(\.theme) private var theme
}

private extension Chip {
    enum Constants {
        static let horizontalPadding: CGFloat = 12
        static let verticalPadding: CGFloat = 10
        static let spacing: CGFloat = 6
        static let strokeWidth: CGFloat = 1
    }
}
