//
//  PrimaryButtonMetrics.swift
//  Music Log
//
//  Created by Lokeswari on 05/07/25.
//


//
//  PrimaryButtonStyle.swift
//  Music Log
//
//  Created by Lokeswari on 05/07/25.
//

import SwiftUI

enum PrimaryButtonMetrics {
    static let cornerRadius: CGFloat = 14
    static let verticalPadding: CGFloat = 14
    static let horizontalPadding: CGFloat = 16
    static let shadowRadius: CGFloat = 4
    static let shadowYOffset: CGFloat = 2
    static let shadowOpacity: Double = 0.1
    static let pressedOpacity: Double = 0.8
}

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.theme) private var theme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .textStyle(.callout, weight: .semibold)
            .frame(maxWidth: .infinity)
            .padding(.vertical, PrimaryButtonMetrics.verticalPadding)
            .padding(.horizontal, PrimaryButtonMetrics.horizontalPadding)
            .background(theme.primary.opacity(configuration.isPressed ? PrimaryButtonMetrics.pressedOpacity : 1))
            .foregroundStyle(theme.textInverse)
            .clipShape(RoundedRectangle(cornerRadius: PrimaryButtonMetrics.cornerRadius, style: .continuous))
            .shadow(
                color: Color.black.opacity(PrimaryButtonMetrics.shadowOpacity),
                radius: PrimaryButtonMetrics.shadowRadius,
                x: 0,
                y: PrimaryButtonMetrics.shadowYOffset
            )
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}
