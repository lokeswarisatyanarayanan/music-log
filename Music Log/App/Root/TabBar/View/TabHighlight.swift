//
//  TabHighlight.swift
//  Music Log
//
//  Created by Lokeswari on 04/07/25.
//

import SwiftUI

struct TabHighlight: View {
    let selectedTab: Tab
    let tabWidth: CGFloat
    let animation: Namespace.ID
    
    @Environment(\.theme) var theme

    var body: some View {
        RoundedRectangle(cornerRadius: TabMetrics.cornerRadius, style: .continuous)
            .fill(theme.primary.opacity(0.15))
            .overlay(
                RoundedRectangle(cornerRadius: TabMetrics.cornerRadius, style: .continuous)
                    .stroke(theme.primary, lineWidth: 1.5)
            )
            .frame(width: tabWidth, height: TabMetrics.highlightHeight)
            .offset(x: offsetX(for: selectedTab))
            .matchedGeometryEffect(id: "highlight", in: animation)
    }

    private func offsetX(for tab: Tab) -> CGFloat {
        guard let index = Tab.allCases.firstIndex(of: tab) else { return 0 }
        return CGFloat(index) * tabWidth
    }
}
