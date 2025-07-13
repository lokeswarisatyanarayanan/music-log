//
//  AddLogSheet.swift
//  Music Log
//
//  Created by Lokeswari on 05/07/25.
//

import SwiftUI
import Iconoir
import UIKit

struct AddLogSheet: View {
    @Environment(\.theme) private var theme
    @Environment(\.dismiss) private var dismiss

    @Binding var isExpanded: Bool
    let track: Track
    let onLog: (Track, Mood, String, String) -> Void
    let keyboardOffset: CGFloat = -45

    @State private var selectedMood: Mood?
    @State private var title: String = ""
    @State private var note: String = ""
    @State private var keyboardObserver: KeyboardObserver = KeyboardObserver()

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        content(proxy: proxy)
                            .padding(.bottom, keyboardObserver.rawHeight > 0 ? keyboardOffset + Metrics.extraScrollPadding : Metrics.extraScrollPadding)
                    }
                    .offset(y: keyboardObserver.rawHeight > 0 ? keyboardOffset : 0)
                }

                VStack(spacing: 0) {
                    Divider().opacity(0.1)

                    Button(isExpanded ? "Add Log" : "Yes") {
                        if !isExpanded {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                isExpanded = true
                            }
                        } else {
                            if let mood = selectedMood {
                                onLog(track, mood, title, note)
                            }
                            dismiss()
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
                .frame(height: isExpanded ? Metrics.buttonHeight : Metrics.buttonCollapsedHeight)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, Metrics.horizontalPadding)
                .padding(.bottom, Metrics.buttonSpacing)
                .background(theme.card)
            }
            .background(theme.card)
            .clipShape(RoundedRectangle(cornerRadius: Metrics.sheetCornerRadius, style: .continuous))
            .animation(.easeOut(duration: 0.25), value: -keyboardOffset)
        }
    }
}

// MARK: - Layout Sections

private extension AddLogSheet {

    func content(proxy: ScrollViewProxy) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            headerSection

            Divider()
                .padding(.bottom, Metrics.sectionSpacing)

            Group {
                moodSection(proxy: proxy)
                    .padding(.bottom, Metrics.sectionSpacing)
                formFields
            }
            .transition(.opacity.combined(with: .move(edge: .bottom)))
            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isExpanded)
            .opacity(isExpanded ? 1 : 0)
        }
        .padding(.horizontal, Metrics.horizontalPadding)
        .padding(.top, Metrics.contentTopPadding)
        .id("top")
    }

    var headerSection: some View {
        Label {
            Text("Add log for \(track.title)?")
                .textStyle(.title2, weight: .semibold)
                .padding(.bottom, Metrics.headerBottomSpacing)
        } icon: {
            Iconoir.musicNotePlus.asImage
                .frame(width: Metrics.iconSize, height: Metrics.iconSize)
        }
    }

    func moodSection(proxy: ScrollViewProxy) -> some View {
        SectionHeaderRow(title: "Mood", icon: .heart) {
            ChipGrid(items: Mood.allCases, selected: selectedMood) { mood in
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    selectedMood = (selectedMood == mood) ? nil : mood
                    isExpanded = selectedMood != nil
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    proxy.scrollTo("top", anchor: .top)
                }
            }
        }
        .padding(.leading, Metrics.sectionLeadingPadding)
    }

    var formFields: some View {
        VStack(spacing: Metrics.sectionSpacing) {
            titleSection
            notesSection
        }
    }

    var titleSection: some View {
        SectionHeaderRow(title: "Title", icon: .editPencil) {
            TextField("Give this a name?", text: $title)
                .padding(Metrics.textFieldPadding)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: Metrics.inputCornerRadius)
                        .fill(theme.background)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: Metrics.inputCornerRadius)
                        .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                )
                .textStyle(.callout)
        }
        .padding(.leading, Metrics.sectionLeadingPadding)
    }

    var notesSection: some View {
        SectionHeaderRow(title: "Your Notes", icon: .text) {
            TextEditor(text: $note)
                .frame(minHeight: Metrics.notesMinHeight)
                .padding(Metrics.textFieldPadding)
                .background(
                    RoundedRectangle(cornerRadius: Metrics.inputCornerRadius)
                        .fill(theme.background)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: Metrics.inputCornerRadius)
                        .stroke(Color.secondary.opacity(0.2), lineWidth: 1)
                )
                .textStyle(.callout)
        }
        .padding(.leading, Metrics.sectionLeadingPadding)
    }
}

// MARK: - Layout Constants

private extension AddLogSheet {
    enum Metrics {
        static let iconSize: CGFloat = 18

        static let contentTopPadding: CGFloat = 36
        static let headerBottomSpacing: CGFloat = 20
        static let sectionSpacing: CGFloat = 28
        static let contentSpacing: CGFloat = 12

        static let buttonSpacing: CGFloat = 12
        static let buttonHeight: CGFloat = 56
        static let buttonCollapsedHeight: CGFloat = 44
        static let extraScrollPadding: CGFloat = 100

        static let horizontalPadding: CGFloat = 20
        static let sectionLeadingPadding: CGFloat = 8
        static let inputCornerRadius: CGFloat = 12
        static let textFieldPadding: CGFloat = 10
        static let notesMinHeight: CGFloat = 120

        static let sheetCornerRadius: CGFloat = 28
    }
}

