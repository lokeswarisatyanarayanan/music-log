//
//  SectionHeaderRow.swift
//  Music Log
//
//  Created by Lokeswari on 05/07/25.
//

import SwiftUI
import Iconoir

struct SectionHeaderRow<Content: View>: View {
    let title: String
    let icon: Iconoir
    var iconSize: CGFloat = 14
    let content: () -> Content

    init(
        title: String,
        icon: Iconoir,
        iconSize: CGFloat = 14,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.icon = icon
        self.iconSize = iconSize
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Label {
                Text(title)
                    .textStyle(.caption, weight: .semibold)
            } icon: {
                icon.asImage
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
            }
            content()
        }
    }
}
