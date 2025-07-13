//
//  SettingsRow.swift
//  Music Log
//
//  Created by Lokeswari on 14/07/25.
//
import SwiftUI
import Iconoir

struct SettingsRow: View {
    let icon: Iconoir
    let label: String
    let value: String
    
    var body: some View {
        HStack(spacing: Metrics.hStackSpacing) {
            
            icon.asImage
                .resizable()
                .frame(width: Metrics.settingsIconSize, height: Metrics.settingsIconSize)
                .foregroundStyle(.gray)
                .padding(.trailing, 6)
            
            Text(label)
                .textStyle(.body)
            
            Spacer()
            
            if !value.isEmpty {
                Text(value)
                    .textStyle(.caption, weight: .semibold)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, Metrics.settingsRowHorizontalPadding)
        .padding(.vertical, Metrics.settingsRowVerticalPadding)
    }
}

private extension SettingsRow {
    private enum Metrics {
        static let hStackSpacing: CGFloat = 6
        static let settingsIconSize: CGFloat = 20
        static let settingsRowHorizontalPadding: CGFloat = 12
        static let settingsRowVerticalPadding: CGFloat = 8
    }
}
