//
//  Collection+.swift
//  HandsTestTask
//
//  Created by Nikita Pavlov on 27.01.2022.
//

import Foundation

extension Collection {
    func allEqual<T: Equatable>(by key: KeyPath<Element, T>) -> Bool {
        return allSatisfy { first?[keyPath:key] == $0[keyPath:key] }
    }
}
