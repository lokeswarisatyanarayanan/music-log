//
//  TrackLogDetailSheet.swift
//  Music Log
//
//  Created by Lokeswari on 13/07/25.
//

import SwiftUI

struct TrackLogDetailSheet: View {
    let log: TrackLog
    @Environment(\.theme) private var theme
    @Environment(\.dismiss) private var dismiss

    @State private var isExpanded = false
    @State private var detents: PresentationDetent = .fraction(0.4)

    var body: some View {
        VStack(spacing: 16) {
            Capsule()
                .frame(width: 40, height: 4)
                .foregroundStyle(.gray.opacity(0.2))
                .padding(.top, 8)

            Text(log.title)
                .textStyle(.title3, weight: .semibold)

            Group {
                if isExpanded {
                    ScrollView {
                        Text(log.note.body)
                            .textStyle(.body)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(minHeight: 120)
                } else {
                    Text(truncatedText(withReadMore: true))
                        .textStyle(.body)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onTapGesture {
                            withAnimation {
                                isExpanded = true
                                detents = .large
                            }
                        }
                }
            }

            HStack(spacing: 8) {
                Text("Mood:")
                    .textStyle(.caption, weight: .semibold)
                Text(log.mood.emoji + "  " + log.mood.label)
                    .textStyle(.caption, weight: .semibold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(theme.primary.opacity(0.4))
                    .clipShape(Capsule())
            }

            Text("Logged on \(log.date.formatted(date: .long, time: .shortened))")
                .textStyle(.caption2)
                .foregroundStyle(.gray)

            Spacer(minLength: 20)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .presentationDetents([.fraction(0.4), .large], selection: $detents)
        .presentationDragIndicator(.hidden)
        .onChange(of: detents) { old, new in
            if new == .fraction(0.4) {
                withAnimation {
                    isExpanded = false
                }
            }
        }
        .background(theme.background.ignoresSafeArea())
    }

    private func truncatedText(withReadMore: Bool) -> AttributedString {
        let limit = 160
        let body = log.note.body
        if body.count <= limit || isExpanded {
            return AttributedString(body)
        }

        var str = AttributedString(String(body.prefix(limit)) + "… ")
        var readMore = AttributedString("Read More")
        readMore.foregroundColor = theme.primary
        readMore.font = .caption.weight(.semibold)
        str.append(readMore)
        return str
    }
}
