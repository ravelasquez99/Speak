//
//  SortTestHelpers.swift
//  SpeakTests
//
//  Created by Richard Velasquez on 4/9/24.
//

import Foundation
import Speak
import XCTest

extension XCTestCase {
    func isSortedAscending<T: Intable>(array: [T]) -> Bool {
        guard array.count > 0 else {
            return true
        }

        var index = 1
        var current = array[0]
        while index < array.count {
            if array[index] < current {
                return false
            }
            
            current = array[index]
            index += 1
        }

        return true
    }
}
