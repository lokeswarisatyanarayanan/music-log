//
//  Date+Extension.swift
//  Music Log
//
//  Created by Lokeswari on 13/07/25.
//
import Foundation

extension Date {
    func relativeTimeString() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
