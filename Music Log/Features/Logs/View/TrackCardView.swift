//
//  TrackCardView.swift
//  Music Log
//
//  Created by Lokeswari on 13/07/25.
//

import SwiftUI
import Iconoir

struct TrackCardView: View {
    let track: LoggedTrack
    @Environment(\.theme) private var theme

    var body: some View {
        HStack(spacing: Metrics.imageSpacing) {
            if let url = track.artworkURL {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.2)
                }
                .frame(width: Metrics.imageWidth, height: Metrics.imageHeight)
                .clipShape(RoundedRectangle(cornerRadius: Metrics.imageCornerRadius))
            }

            VStack(alignment: .leading, spacing: Metrics.textSpacing) {
                Text(track.title)
                    .textStyle(.body, weight: .semibold)

                Text(track.artist)
                    .textStyle(.caption)
                    .foregroundStyle(theme.textSecondary)

                if let last = track.logs.last {
                    Text("Last logged on \(last.date.formatted(date: .abbreviated, time: .omitted))")
                        .textStyle(.caption)
                        .foregroundStyle(.gray)
                }

                Text("\(track.logs.count) \(track.logs.count == 1 ? "log" : "logs")")
                    .textStyle(.caption, weight: .thin)
                    .foregroundStyle(.gray)
            }

            Spacer()

            Iconoir.navArrowRight.asImage
                .font(.system(size: Metrics.chevronSize, weight: .medium))
                .foregroundStyle(theme.textSecondary)
        }
        .padding()
        .background(theme.card)
        .clipShape(RoundedRectangle(cornerRadius: Metrics.cardCornerRadius))
        .shadow(color: theme.textPrimary.opacity(0.07), radius: Metrics.cardShadowRadius, x: 0, y: 2)
        .padding(.horizontal, Metrics.horizontalPadding)
    }

    private enum Metrics {
        static let imageWidth: CGFloat = 90
        static let imageHeight: CGFloat = 100
        static let imageSpacing: CGFloat = 12
        static let imageCornerRadius: CGFloat = 12
        static let textSpacing: CGFloat = 6
        static let chevronSize: CGFloat = 14
        static let cardCornerRadius: CGFloat = 14
        static let cardShadowRadius: CGFloat = 4
        static let horizontalPadding: CGFloat = 16
    }
}
