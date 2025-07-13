//
//  SectionTitle.swift
//  Music Log
//
//  Created by Lokeswari on 04/07/25.
//


import SwiftUI
import Iconoir

struct SectionTitle: View {
    let title: String
    let icon: Iconoir?

    init(title: String, icon: Iconoir? = nil) {
        self.title = title
        self.icon = icon
    }

    var body: some View {
        HStack(spacing: 8) {
            if let icon = icon {
                icon.asImage
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundStyle(.primary)
                    .offset(y: -1) 
            }

            Text(title)
                .textStyle(.headline, weight: .bold)
                .foregroundStyle(.primary)

            Spacer()
        }
        .padding(.horizontal, 4)
        .padding(.top, 8)
    }
}

