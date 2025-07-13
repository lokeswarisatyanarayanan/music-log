//
//  TextStyle+View.swift
//  Music Log
//
//  Created by Lokeswari on 05/07/25.
//

import SwiftUI

extension View {
    func textStyle(_ style: TextStyle, weight: Font.Weight? = nil) -> some View {
        self.font(style.font(weight: weight))
    }
}
