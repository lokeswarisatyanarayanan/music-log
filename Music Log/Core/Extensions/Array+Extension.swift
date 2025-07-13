//
//  Array+Extension.swift
//  Music Log
//
//  Created by Lokeswari on 04/07/25.
//

extension Array {
    func uniqued<T: Hashable>(by key: (Element) -> T) -> [Element] {
        var seen = Set<T>()
        return filter { seen.insert(key($0)).inserted }
    }
}
