//
//  TrackLogCardView.swift
//  Music Log
//
//  Created by Lokeswari on 13/07/25.
//

import SwiftUI

struct TrackLogCardView: View {
    let log: TrackLog
    @Environment(\.theme) private var theme
    
    var body: some View {
        VStack(alignment: .leading, spacing: Metrics.verticalSpacing) {
            HStack {
                Text(log.title)
                    .textStyle(.body, weight: .semibold)
                
                Spacer()
                
                HStack {
                    Text(log.mood.emoji)
                    Text(log.mood.label)
                }
                .textStyle(.caption2, weight: .semibold)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(theme.primary.opacity(0.3))
                .clipShape(Capsule())
            }
            
            Text(log.note.body)
                .textStyle(.callout)
                .foregroundStyle(theme.textSecondary)
                .lineLimit(3)
            
            Text(log.date.formatted(date: .long, time: .shortened))
                .textStyle(.caption2)
                .foregroundStyle(.gray)
        }
        .padding()
        .background(theme.card)
        .clipShape(RoundedRectangle(cornerRadius: Metrics.cardCornerRadius))
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        .padding(.horizontal, Metrics.horizontalPadding)
    }
    
    private enum Metrics {
        static let verticalSpacing: CGFloat = 8
        static let cardCornerRadius: CGFloat = 16
        static let horizontalPadding: CGFloat = 16
    }
}
