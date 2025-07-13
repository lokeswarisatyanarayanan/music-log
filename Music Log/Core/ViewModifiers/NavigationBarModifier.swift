//
//  NavigationBarModifier.swift
//  Music Log
//
//  Created by Lokeswari on 13/07/25.
//

import SwiftUI
import Iconoir

struct NavigationBarModifier: ViewModifier {
    let title: String?
    let showBackButton: Bool

    @Environment(\.dismiss) private var dismiss
    @Environment(\.theme) private var theme

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                if showBackButton {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { dismiss() }) {
                            Iconoir.navArrowLeft.asImage
                                .foregroundStyle(theme.textPrimary)
                                .font(.system(size: 24).bold())
                        }
                    }
                }

                if let t = title {
                    ToolbarItem(placement: .principal) {
                        Text(t)
                            .textStyle(.title3, weight: .semibold)
                            .foregroundStyle(theme.textPrimary)
                    }
                }
            }
    }
}

extension View {
    func navigationBar(title: String? = nil,
                               showBackButton: Bool = true) -> some View {
        modifier(NavigationBarModifier(title: title,
                                               showBackButton: showBackButton))
    }
}
