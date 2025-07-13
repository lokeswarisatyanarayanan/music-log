//
//  LogView.swift
//  Music Log
//
//  Created by Lokeswari on 13/07/25.
//


import SwiftUI

struct LogView: View {
    @Bindable var viewModel: LogViewModel
    @Environment(\.theme) private var theme
    @Namespace private var animation
    
    @State private var selectedTrack: LoggedTrack?
    @State private var selectedLog: TrackLog?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: Metrics.cardSpacing) {
                    ForEach(viewModel.logs) { track in
                        TrackCardView(track: track)
                            .onTapGesture {
                                withAnimation {
                                    selectedTrack = track
                                }
                            }
                    }
                }
                .padding(.top)
                .padding(.bottom, Metrics.bottomPadding)
            }
            .background(theme.background.ignoresSafeArea())
            .navigationTitle("Logs")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(item: $selectedTrack) { track in
                TrackLogsView(track: track) { log in
                    selectedLog = log
                }
            }
            .sheet(item: $selectedLog) { log in
                TrackLogDetailSheet(log: log)
            }
        }
    }
    
    private enum Metrics {
        static let cardSpacing: CGFloat = 20
        static let bottomPadding: CGFloat = 100
    }
}
