//
//  ProfileView.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import SwiftUI
import Iconoir

struct ProfileView: View {
    let viewModel: ProfileViewModel
    
    @Environment(\.theme) private var theme
    @State private var displayName: String = ""
    @State private var email: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Spacer()
                        VStack(spacing: Metrics.headerSpacing) {
                            headerContent
                        }
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .padding(.vertical, Metrics.headerVerticalPadding)
                }
                
                Section(header: Text("USAGE STATS")) {
                    SettingsRow(icon: Iconoir.bookSolid, label: "Your logs", value: "40")
                    SettingsRow(icon: Iconoir.musicNoteSolid, label: "Your Tracks", value: "18")
                }
                .listRowBackground(theme.card)
                
                Section(header: Text("APP INFO")) {
                    SettingsRow(icon: Iconoir.clockSolid, label: "Version", value: "1.0.0")
                    SettingsRow(icon: Iconoir.heartSolid, label: "Made with love by Sindhu", value: "")
                }
                .listRowBackground(theme.card)
                
                Section {
                    HStack {
                        Spacer()
                        disconnectButton
                        Spacer()
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .padding(.top, Metrics.disconnectTopPadding)
                    .padding(.bottom, Metrics.disconnectBottomPadding)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(theme.background)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .task {
                await viewModel.loadProfile()
                if let user = viewModel.user {
                    displayName = user.displayName
                    email = user.email
                }
            }
        }
    }
    
    private var headerContent: some View {
        HStack(spacing: Metrics.headerSpacing) {
            profileImage
                .padding(.trailing, Metrics.headerSpacing)
            VStack(alignment: .leading) {
                userInfo
                connectionStatus
            }
            Spacer()
        }
    }
    
    private var profileImage: some View {
        Group {
            if let url = viewModel.user?.imageURL {
                userProfileImage(url: url)
            } else {
                placeholderImage
            }
        }
        .frame(width: Metrics.imageSize, height: Metrics.imageSize)
        .clipShape(RoundedRectangle(cornerRadius: Metrics.imageCornerRadius))
    }
    
    private func userProfileImage(url: URL) -> some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
        }
        .overlay(profileImageBorder)
        .shadow(radius: Metrics.imageShadowRadius)
    }
    
    private var placeholderImage: some View {
        RoundedRectangle(cornerRadius: Metrics.imageCornerRadius)
            .fill(theme.secondary.opacity(0.1))
            .overlay(
                Iconoir.user.asImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: Metrics.placeholderIconSize, height: Metrics.placeholderIconSize)
                    .foregroundColor(theme.textSecondary)
            )
    }
    
    private var profileImageBorder: some View {
        RoundedRectangle(cornerRadius: Metrics.imageCornerRadius)
            .stroke(theme.primary, lineWidth: Metrics.imageStrokeWidth)
            .shadow(color: theme.primary.opacity(0.3), radius: Metrics.imageShadowRadius)
    }
    
    private var userInfo: some View {
        VStack(alignment: .leading, spacing: Metrics.userInfoSpacing) {
            Text(displayName)
                .textStyle(.title2, weight: .semibold)
            
            Text(email)
                .textStyle(.body)
                .foregroundColor(theme.textPrimary)
        }
    }
    
    private var connectionStatus: some View {
        Group {
            if viewModel.isLoading {
                loadingIndicator
            } else if viewModel.user != nil {
                connectedIndicator
            }
        }
    }
    
    private var loadingIndicator: some View {
        ProgressView("Loading Spotify Profile…")
            .textStyle(.caption)
            .padding(.top, Metrics.loadingTopPadding)
    }
    
    private var connectedIndicator: some View {
        HStack(spacing: Metrics.spotifyStatusSpacing) {
            Iconoir.spotify.asImage
                .resizable()
                .frame(width: Metrics.spotifyIconSize, height: Metrics.spotifyIconSize)
                .foregroundColor(.green)
            
            Text("Connected".uppercased())
                .foregroundColor(.green)
                .textStyle(.caption, weight: .semibold)
        }
        .padding(.top, Metrics.spotifyStatusTopPadding)
    }
    
    private var disconnectButton: some View {
        Button {
            viewModel.disconnect()
        } label: {
            HStack {
                Iconoir.logOut.asImage
                Text("Disconnect")
            }
            .textStyle(.body, weight: .semibold)
            .foregroundColor(.red)
            .padding(.horizontal, Metrics.buttonHorizontalPadding)
            .padding(.vertical, Metrics.buttonVerticalPadding)
            .frame(maxWidth: .infinity)
            .background(theme.card)
            .clipShape(RoundedRectangle(cornerRadius: Metrics.buttonCornerRadius))
            .shadow(color: .black.opacity(0.05), radius: Metrics.buttonShadowRadius, x: 0, y: Metrics.buttonShadowY)
        }
    }
}

private extension ProfileView {
    enum Metrics {
        // Reduced header spacing and sizes
        static let headerSpacing: CGFloat = 8
        static let imageSize: CGFloat = 100
        static let imageCornerRadius: CGFloat = 20
        static let headerVerticalPadding: CGFloat = 12
        
        // Reduced user info spacing
        static let userInfoSpacing: CGFloat = 2
        static let spotifyStatusTopPadding: CGFloat = 2
        static let loadingTopPadding: CGFloat = 4
        
        // Image styling
        static let imageStrokeWidth: CGFloat = 3
        static let imageShadowRadius: CGFloat = 4
        static let placeholderIconSize: CGFloat = 28
        static let spotifyIconSize: CGFloat = 14
        static let spotifyStatusSpacing: CGFloat = 4
        
        // Settings row reduced sizes
        static let settingsIconSize: CGFloat = 18
        static let settingsRowHorizontalPadding: CGFloat = 12
        static let settingsRowVerticalPadding: CGFloat = 8
        
        // Button reduced padding
        static let buttonHorizontalPadding: CGFloat = 16
        static let buttonVerticalPadding: CGFloat = 12
        static let buttonCornerRadius: CGFloat = 10
        static let buttonShadowRadius: CGFloat = 3
        static let buttonShadowY: CGFloat = 1
        
        // Disconnect button positioning
        static let disconnectTopPadding: CGFloat = 12
        static let disconnectBottomPadding: CGFloat = 20
        
        // Unused legacy values (can be removed)
        static let verticalSpacing: CGFloat = 24
        static let formTopInset: CGFloat = 20
    }
}
