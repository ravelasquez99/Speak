//
//  RadixSortTests.swift
//  SpeakTests
//
//  Created by Richard Velasquez on 4/9/24.
//

import Speak
import XCTest

final class RadixSortTests: XCTestCase {
    
    func testEmptyArray() {
        var array = [Int]()
        RadixSorter.sort(&array)
        XCTAssertTrue(isSortedAscending(array: array), "Array should be sorted")
    }

    func testSingleElement() {
        var array = [42]
        RadixSorter.sort(&array)
        XCTAssertTrue(isSortedAscending(array: array), "Array should be sorted")
    }

    func testAlreadySortedArray() {
        var array = [1, 2, 3, 4, 5]
        RadixSorter.sort(&array)
        XCTAssertTrue(isSortedAscending(array: array), "Array should remain sorted")
    }

    func testReverseSortedArray() {
        var array = [5, 4, 3, 2, 1]
        RadixSorter.sort(&array)
        XCTAssertTrue(isSortedAscending(array: array), "Array should be sorted in ascending order")
    }

    func testRandomArray() {
        var array = [3, 1, 4, 1, 5, 9, 2, 6]
        RadixSorter.sort(&array)
        XCTAssertTrue(isSortedAscending(array: array), "Array should be sorted in ascending order")
    }

    func testArrayWithDuplicates() {
        var array = [5, 3, 3, 2, 1, 4, 5]
        RadixSorter.sort(&array)
        XCTAssertTrue(isSortedAscending(array: array), "Array should be sorted in ascending order, with duplicates next to each other")
    }

    func testLargeNumbers() {
        var array = [12345, 67890, 123, 4567, 89012]
        RadixSorter.sort(&array)
        XCTAssertTrue(isSortedAscending(array: array), "Array should be sorted in ascending order, even with large numbers")
    }

    private func isSortedAscending<T: Intable>(array: [T]) -> Bool {
        guard array.count > 0 else {
            return true
        }

        var index = 1
        var current = array[0]
        while index < array.count {
            if array[index] < current {
                return false
            }
            
            index += 1
        }

        return true
    }
}
