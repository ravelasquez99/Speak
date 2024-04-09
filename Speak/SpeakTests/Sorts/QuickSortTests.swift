//
//  QuickSortTests.swift
//  SpeakTests
//
//  Created by Richard Velasquez on 4/9/24.
//

import Speak
import XCTest

final class QuickSortTests: XCTestCase {
    func testQuickSortWithEmptyArray() {
        var array = [Int]()
        QuickSorter.sort(&array)
        XCTAssertTrue(isSortedAscending(array: array), "Empty array should be considered sorted")
    }

    func testQuickSortWithSingleElement() {
        var array = [42]
        QuickSorter.sort(&array)
        XCTAssertTrue(isSortedAscending(array: array), "Single-element array should be considered sorted")
    }

    func testQuickSortWithAlreadySortedArray() {
        var array = [1, 2, 3, 4, 5]
        QuickSorter.sort(&array)
        XCTAssertTrue(isSortedAscending(array: array), "Already sorted array should remain sorted")
    }

    func testQuickSortWithReverseSortedArray() {
        var array = [5, 4, 3, 2, 1]
        QuickSorter.sort(&array)
        XCTAssertTrue(isSortedAscending(array: array), "Reverse sorted array should be sorted in ascending order")
    }

    func testQuickSortWithRandomElements() {
        var array = [3, 1, 4, 1, 5, 9, 2, 6]
        QuickSorter.sort(&array)
        XCTAssertTrue(isSortedAscending(array: array), "Array with random elements should be sorted in ascending order")
    }

    func testQuickSortWithDuplicateElements() {
        var array = [5, 3, 3, 2, 1, 4, 5]
        QuickSorter.sort(&array)
        XCTAssertTrue(isSortedAscending(array: array), "Array with duplicates should be sorted in ascending order, maintaining duplicates")
    }
}

