//
//  TrackCard.swift
//  Music Log
//
//  Created by Lokeswari on 04/07/25.
//

import SwiftUI
import Iconoir

struct TrackCard: View {
    let track: Track
    @Environment(\.theme) private var theme

    var body: some View {
        HStack(spacing: Metrics.imageSpacing) {
            if let url = track.artworkURL {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(width: Metrics.imageSize, height: Metrics.imageSize)
                .clipShape(RoundedRectangle(cornerRadius: Metrics.imageCornerRadius))
            }

            VStack(alignment: .leading, spacing: Metrics.textSpacing) {
                Text(track.title)
                    .textStyle(.body, weight: .medium)
                    .foregroundStyle(theme.textPrimary)

                Text(track.artist)
                    .textStyle(.caption, weight: .light)
                    .foregroundStyle(theme.textSecondary)
                
                if let playedAt = track.playedAt?.toSpotifyDate() {
                    Text("Last listened \(playedAt.relativeTimeString())")
                        .textStyle(.caption2)
                        .foregroundStyle(theme.textSecondary)
                }

            }
            Spacer()
        }
        .padding()
        .background(theme.card)
        .clipShape(RoundedRectangle(cornerRadius: Metrics.cardCornerRadius))
        .shadow(color: theme.textPrimary.opacity(0.06), radius: 4, x: 0, y: 2)
    }

    private enum Metrics {
        static let imageSize: CGFloat = 80
        static let imageSpacing: CGFloat = 12
        static let imageCornerRadius: CGFloat = 12
        static let textSpacing: CGFloat = 4
        static let cardCornerRadius: CGFloat = 14
        static let iconSize: CGFloat = 20
    }
}
