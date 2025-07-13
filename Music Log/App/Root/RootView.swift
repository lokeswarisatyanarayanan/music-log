//
//  RootView.swift
//  Music Log
//
//  Created by Lokeswari on 29/06/25.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @Environment(\.modelContext) private var context
    @State private var selectedTab: Tab = .home

    var body: some View {
        let environment = AppEnvironment.live(context: context)

        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView(viewModel: environment.homeViewModel)
                case .log:
                    LogView(viewModel: environment.logViewModel)
                case .profile:
                    ProfileView(viewModel: environment.profileViewModel)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()

            MusicLogTabBar(selectedTab: $selectedTab)
        }
        .environment(environment)
    }
}
