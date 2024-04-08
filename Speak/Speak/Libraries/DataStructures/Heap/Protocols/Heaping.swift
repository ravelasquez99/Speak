//
//  Heaping.swift
//  Speak
//
//  Created by Richard Velasquez on 4/8/24.
//

import Foundation

public protocol Heaping {
    associatedtype Item: Comparable
    init(array: [Item])
    var isEmpty: Bool { get }
    var count: Int { get }
    func insert(_ value: Item)
    func extractTop() -> Item?
    func peek() -> Item?
    var heap: [Item] { get }
}
