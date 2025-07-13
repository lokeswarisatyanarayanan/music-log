//
//  ChipGrid.swift
//  Music Log
//
//  Created by Lokeswari on 05/07/25.
//
import SwiftUI

struct ChipGrid: View {
    let items: [Mood]
    let selected: Mood?
    let onSelect: (Mood?) -> Void

    var body: some View {
        LazyVGrid(columns: ChipGridMetrics.columns, spacing: ChipGridMetrics.gridSpacing) {
            ForEach(items, id: \.self) { mood in
                let isSelected = selected == mood
                Chip(label: mood.label, isSelected: isSelected, emoji: mood.emoji) {
                    onSelect(isSelected ? nil : mood)
                }
                .transition(.scale.combined(with: .opacity))
                .animation(.spring(response: 0.35, dampingFraction: 0.7), value: selected)
            }
        }
    }

    private enum ChipGridMetrics {
        static let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 12), count: 3)
        static let gridSpacing: CGFloat = 12
    }
}
