//
//  HomeView.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import SwiftUI
import Iconoir

struct HomeView: View {
    @Bindable var viewModel: HomeViewModel
    @Environment(\.theme) private var theme
    
    @State private var selectedTrack: Track?
    @State private var detent: PresentationDetent = Metrics.collapsedDetent
    
    private var isCompactSheetPresented: Bool {
        selectedTrack != nil && detent != .large
    }
    
    var body: some View {
        ScalableBackgroundView(isActive: isCompactSheetPresented) {
            NavigationStack {
                ScrollView {
                    VStack(spacing: Metrics.sectionSpacing) {
                        if viewModel.isLoading {
                            VStack {
                                nowPlayingPlaceholder
                                recentlyPlayedPlaceholder
                            }
                            .padding()
                        } else {
                            nowPlayingSection
                            recentlyPlayedSection
                            errorSection
                        }
                    }
                    .padding()
                }
                .background(theme.background)
                .navigationTitle("Home")
                .task { await viewModel.load() }
            }
            .sheet(item: $selectedTrack, onDismiss: { detent = Metrics.collapsedDetent }) { track in
                AddLogSheet(
                    isExpanded: Binding(
                        get: { detent == .large },
                        set: { detent = $0 ? .large : Metrics.collapsedDetent }
                    ),
                    track: track,
                    onLog: { track, mood, title, note in
                        viewModel.log(track: track, mood: mood, title: title, note: note)
                    }
                )
                .presentationDetents([Metrics.collapsedDetent, .large], selection: $detent)
                .presentationBackground(theme.card)
            }
        }
    }
    
    // MARK: - Subviews
    
    private var nowPlayingPlaceholder: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionTitle(title: "Now Playing", icon: Iconoir.musicNote)
            RoundedRectangle(cornerRadius: 16)
                .fill(theme.card)
                .frame(height: 120)
                .redacted(reason: .placeholder)
                .shimmer()
        }
    }

    private var recentlyPlayedPlaceholder: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionTitle(title: "Recently Played", icon: Iconoir.activity)
            ForEach(0..<3, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 12)
                    .fill(theme.card)
                    .frame(height: 100)
                    .redacted(reason: .placeholder)
                    .shimmer()
            }
        }
    }

    
    private var nowPlayingSection: some View {
        Group {
            if let nowPlaying = viewModel.nowPlayingTrack {
                SectionTitle(title: "Now Playing", icon: Iconoir.musicNote)
                NowPlayingCard(track: nowPlaying)
                    .onTapGesture { selectedTrack = nowPlaying }
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .animation(.spring(), value: nowPlaying.id)
            }
        }
    }
    
    private var recentlyPlayedSection: some View {
        Group {
            if !viewModel.recentlyPlayedTracks.isEmpty {
                SectionTitle(title: "Recently Played", icon: Iconoir.activity)
                VStack(spacing: 12) {
                    ForEach(viewModel.recentlyPlayedTracks) { track in
                        TrackCard(track: track)
                            .onTapGesture { selectedTrack = track }
                    }
                }
            }
        }
    }
    
    private var errorSection: some View {
        Group {
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
                    .textStyle(.caption, weight: .light)
                    .padding()
            }
        }
    }
}

private extension HomeView {
    enum Metrics {
        static let cornerRadiusCompact: CGFloat = 20
        static let topPaddingCompact: CGFloat = 12
        static let scaleCompact: CGFloat = 0.95
        static let shadowRadius: CGFloat = 12
        static let shadowYOffset: CGFloat = 4
        static let backgroundFadeOpacity: Double = 0.3

        static let sectionSpacing: CGFloat = 24
        static let cardSpacing: CGFloat = 12
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 20

        static let collapsedDetent: PresentationDetent = .height(220)
        static let expandedDetent: PresentationDetent = .large
    }
}
