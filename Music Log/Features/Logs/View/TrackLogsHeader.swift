//
//  TrackLogsHeader.swift
//  Music Log
//
//  Created by Lokeswari on 13/07/25.
//

import SwiftUI

struct TrackLogsHeader: View {
    let track: LoggedTrack
    @Environment(\.theme) private var theme

    private func formattedDuration(from milliseconds: Int) -> String {
        let totalSeconds = milliseconds / 1000
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    var body: some View {
        VStack(spacing: 12) {
            if let url = track.artworkURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 3)
                    default:
                        Color.gray.opacity(0.2)
                            .frame(height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            }

            Text("\(track.artist.uppercased())  •  \(track.album?.uppercased() ?? "")")
                .textStyle(.caption2, weight: .regular)
                .foregroundStyle(theme.textSecondary)
        }
    }
}
