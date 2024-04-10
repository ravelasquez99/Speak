//
//  MergeSortTests.swift
//  SpeakTests
//
//  Created by Richard Velasquez on 4/10/24.
//

import Speak
import XCTest

final class MergeSortTests: XCTestCase {

    func testMergeSortWithEmptyArray() {
        let array: [Int] = []
        let sortedArray = MergeSorter.mergeSort(array)
        XCTAssertTrue(isSortedAscending(array: sortedArray), "Array should be sorted")
    }

    func testMergeSortWithSingleElement() {
        let array = [1]
        let sortedArray = MergeSorter.mergeSort(array)
        XCTAssertTrue(isSortedAscending(array: sortedArray), "Array with single element should be considered sorted")
    }

    func testMergeSortWithMultipleElements() {
        let array = [5, 3, 8, 6, 2, 7, 4, 1]
        let sortedArray = MergeSorter.mergeSort(array)
        XCTAssertTrue(isSortedAscending(array: sortedArray), "Array should be sorted in ascending order")
    }

    func testMergeSortWithReversedArray() {
        let array = [9, 8, 7, 6, 5, 4, 3, 2, 1]
        let sortedArray = MergeSorter.mergeSort(array)
        XCTAssertTrue(isSortedAscending(array: sortedArray), "Reversed array should be sorted in ascending order")
    }

    func testMergeSortWithAlreadySortedArray() {
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let sortedArray = MergeSorter.mergeSort(array)
        XCTAssertTrue(isSortedAscending(array: sortedArray), "Already sorted array should remain sorted")
    }
}

