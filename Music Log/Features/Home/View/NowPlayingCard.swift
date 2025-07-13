//
//  NowPlayingCard.swift
//  Music Log
//
//  Created by Lokeswari on 04/07/25.
//

import SwiftUI
import Iconoir

struct NowPlayingCard: View {
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
                .aspectRatio(1, contentMode: .fill)
                .frame(width: Metrics.imageSize, height: Metrics.imageSize)
                .clipShape(RoundedRectangle(cornerRadius: Metrics.imageCornerRadius))
            }

            VStack(alignment: .leading, spacing: Metrics.textSpacing) {
                Text(track.title)
                    .textStyle(.body, weight: .semibold)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                
                Text(formattedMeta())
                    .textStyle(.caption2)
                    .foregroundStyle(theme.textSecondary)
                    .lineLimit(1)

                HStack(spacing: 6) {
                    Iconoir.seaWaves.asImage
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(theme.tint)
                    Text("Now Playing")
                        .textStyle(.caption2, weight: .semibold)
                        .foregroundStyle(theme.tint)
                }
            }

            Spacer()
        }
        .padding()
        .background(theme.card)
        .clipShape(RoundedRectangle(cornerRadius: Metrics.cardCornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: Metrics.cardCornerRadius)
                .stroke(Color.green.opacity(0.2), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }

    private func formattedMeta() -> String {
        var parts: [String] = []
        parts.append(track.artist)
        if let duration = track.durationMs {
            parts.append(formattedDuration(from: duration))
        }
        return parts.joined(separator: " • ")
    }
    
    private func formattedDuration(from milliseconds: Int) -> String {
        let totalSeconds = milliseconds / 1000
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    private enum Metrics {
        static let imageSize: CGFloat = 90
        static let imageSpacing: CGFloat = 16
        static let imageCornerRadius: CGFloat = 12
        static let textSpacing: CGFloat = 8
        static let cardCornerRadius: CGFloat = 16
    }
}
