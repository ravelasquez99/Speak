//
//  BinarySearchTests.swift
//  SpeakTests
//
//  Created by Richard Velasquez on 4/10/24.
//

import Speak
import XCTest

final class BinarySearchTests: XCTestCase {
    
    func testEmptyArray() {
        let result = BinarySearcher.findElement(1, in: [])
        XCTAssertNil(result, "Search in an empty array should return nil.")
    }
    
    func testSingleElementArrayWithTarget() {
        let result = BinarySearcher.findElement(1, in: [1])
        XCTAssertEqual(result, 0, "Search should find the element in an array with a single element.")
    }
    
    func testSingleElementArrayWithoutTarget() {
        let result = BinarySearcher.findElement(2, in: [1])
        XCTAssertNil(result, "Search should not find an element not present in a single-element array.")
    }
    
    func testMultipleElementsWithTarget() {
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let target = 7
        let result = BinarySearcher.findElement(target, in: array)
        XCTAssertEqual(result, array.firstIndex(of: target), "Search should find the target element in the array.")
    }
    
    func testMultipleElementsWithoutTarget() {
        let array = [1, 3, 4, 6, 7, 8, 10]
        let result = BinarySearcher.findElement(2, in: array)
        XCTAssertNil(result, "Search should not find an element that isn't present in the array.")
    }
    
    func testTargetAsFirstElement() {
        let array = [1, 2, 3, 4, 5]
        let result = BinarySearcher.findElement(1, in: array)
        XCTAssertEqual(result, 0, "Search should be able to find the first element as the target.")
    }
    
    func testTargetAsLastElement() {
        let array = [1, 2, 3, 4, 5]
        let result = BinarySearcher.findElement(5, in: array)
        XCTAssertEqual(result, array.count - 1, "Search should be able to find the last element as the target.")
    }
}
