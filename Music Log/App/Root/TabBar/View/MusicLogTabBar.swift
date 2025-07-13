//
//  MusicLogTabBar.swift
//  Music Log
//
//  Created by Lokeswari on 04/07/25.
//

import SwiftUI
import Iconoir

//MARK: Layout
enum TabMetrics {
    static let height: CGFloat = 64
    static let cornerRadius: CGFloat = 12
    static let horizontalPadding: CGFloat = 24
    static let highlightHeight: CGFloat = 40

    static func calculateTabWidth(geometryWidth: CGFloat, tabCount: Int) -> CGFloat {
        let totalHorizontalPadding = horizontalPadding * 4
        let availableWidth = geometryWidth - totalHorizontalPadding
        return availableWidth / CGFloat(tabCount)
    }
}

//MARK: View
struct MusicLogTabBar: View {
    @Binding var selectedTab: Tab
    @Environment(\.theme) private var theme
    @Namespace private var animation

    var body: some View {
        GeometryReader { geometry in
            let tabCount = Tab.allCases.count
            let tabWidth = TabMetrics.calculateTabWidth(geometryWidth: geometry.size.width, tabCount: tabCount)

            ZStack(alignment: .leading) {
                TabHighlight(selectedTab: selectedTab, tabWidth: tabWidth, animation: animation)

                HStack(spacing: 0) {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        TabButton(
                            tab: tab,
                            tabWidth: tabWidth,
                            isSelected: selectedTab == tab
                        ) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedTab = tab
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, TabMetrics.horizontalPadding)
            .frame(height: TabMetrics.height)
            .background(theme.surfaceBackground)
            .clipShape(Capsule())
            .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 6)
            .padding(.horizontal, TabMetrics.horizontalPadding)
            .padding(.bottom, 8)
        }
        .frame(height: TabMetrics.height + 16)
    }
}


