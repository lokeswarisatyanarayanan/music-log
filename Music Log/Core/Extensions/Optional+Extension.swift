//
//  Optional+Extension.swift
//  Music Log
//
//  Created by Lokeswari on 04/07/25.
//

import Foundation

extension Optional: EmptyDecodable where Wrapped: EmptyDecodable {
    static var empty: Optional<Wrapped> {
        .some(Wrapped.empty)
    }
}
