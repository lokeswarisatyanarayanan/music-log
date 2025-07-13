//
//  TrackLogsView.swift
//  Music Log
//
//  Created by Lokeswari on 13/07/25.
//

import SwiftUI

struct TrackLogsView: View {
    let track: LoggedTrack
    let onSelectLog: (TrackLog) -> Void

    @Environment(\.theme) private var theme
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: Metrics.cardSpacing) {
                    TrackLogsHeader(track: track)

                    ForEach(track.logs) { log in
                        TrackLogCardView(log: log)
                            .onTapGesture {
                                withAnimation {
                                    onSelectLog(log)
                                }
                            }
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationBar()
        .background(theme.background.ignoresSafeArea())
    }

    private enum Metrics {
        static let cardSpacing: CGFloat = 20
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 8
    }
}
