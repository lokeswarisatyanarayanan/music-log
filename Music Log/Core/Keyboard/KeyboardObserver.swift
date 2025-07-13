//
//  KeyboardObserver.swift
//  Music Log
//
//  Created by Lokeswari on 08/07/25.
//

import SwiftUI
import Observation

@Observable
final class KeyboardObserver {
    private(set) var rawHeight: CGFloat = 0

    init() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil,
            queue: .main
        ) { notification in
            guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
                  let window = UIApplication.shared.connectedScenes
                    .compactMap({ ($0 as? UIWindowScene)?.keyWindow }).first else { return }

            let keyboardTop = frame.origin.y
            let windowHeight = window.bounds.height
            let overlap = max(0, windowHeight - keyboardTop)

            withAnimation(.easeOut(duration: 0.25)) {
                self.rawHeight = overlap
            }
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
