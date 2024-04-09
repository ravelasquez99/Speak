//
//  HeapTests.swift
//  SpeakTests
//
//  Created by Richard Velasquez on 4/4/24.
//

import Speak
import XCTest



final class HeapTests: XCTestCase {
    let initialArray = [31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 5, 3, 1, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 19, 4, 18, 2, 17]

    func testInitialHeapIsInvalid() {
        XCTAssertFalse(isValidMinHeap(array: initialArray, parentValue: nil))
    }
    
    func testEmptyHeapIsValid() {
        XCTAssert(isValidMinHeap(array: []))
    }

    func testValidMinHeapIsValid() {
        XCTAssert(isValidMinHeap(array: [1, 2, 3, 4, 5, 6, 7, 8, 9]))
        XCTAssert(isValidMinHeap(array: [1, 3, 2, 4, 7, 8, 5, 9, 6]))
    }

    func testSetupOfInitialChatGPTMinHeap() {
        let heap = ChatGPTMinHeap(array: initialArray)
        XCTAssert(isValidMinHeap(array: heap.heap))
    }

    func testSetupOfMinHeap() {
        XCTAssert(
            isValidMinHeap(
                array: MinHeap(array: initialArray).heap
            )
        )
    }

    // Test for `isEmpty` functionality
    func testIsEmpty() {
        let emptyHeap = MinHeap<Int>(array: [])
        XCTAssertTrue(emptyHeap.isEmpty)
        
        let nonEmptyHeap = MinHeap(array: [1])
        XCTAssertFalse(nonEmptyHeap.isEmpty)
    }

    // Test for `count` functionality
    func testCount() {
        let heap = MinHeap(array: initialArray)
        XCTAssertEqual(heap.count, initialArray.count)
        
        heap.insert(0) // Assuming insert works
        XCTAssertEqual(heap.count, initialArray.count + 1)
        
        _ = heap.extractTop() // Assuming extractMin works
        XCTAssertEqual(heap.count, initialArray.count)
    }

    // Test for `peek` functionality
    func testPeek() {
        let heap = MinHeap(array: initialArray.sorted())
        XCTAssertNotNil(heap.peek())
        XCTAssertEqual(heap.peek(), initialArray.min())
        
        while !heap.isEmpty {
            _ = heap.extractTop()
        }
        
        XCTAssertNil(heap.peek())
    }

    // Test for `extractMin` functionality
    func testExtractMin() {
        let sortedArray = initialArray.sorted()
        let heap = MinHeap(array: sortedArray)
        for value in sortedArray {
            XCTAssertEqual(heap.extractTop(), value)
            XCTAssert(isValidMinHeap(array: heap.heap))
        }
        
        XCTAssertTrue(heap.isEmpty)
        XCTAssertNil(heap.extractTop())
    }

    // Test for `insert` functionality
    func testInsert() {
        let heap = MinHeap<Int>(array: [])
        for value in initialArray {
            heap.insert(value)
            XCTAssert(isValidMinHeap(array: heap.heap))
        }
        
        XCTAssertEqual(heap.count, initialArray.count)
        XCTAssertFalse(heap.isEmpty)
        XCTAssertEqual(heap.peek(), initialArray.min())
    }

    func isValidMinHeap(
        array: [Int],
        index: Int = 0,
        parentValue: Int? = nil
    ) -> Bool {
        guard index < array.count else {
            return true
        }

        let currentNodeValue = array[index]
        if let theParentValue = parentValue {
            if theParentValue > currentNodeValue {
                return false
            }
        }

        return isValidMinHeap(
            array: array,
            index: HeapHelpers.leftChildIndex(ofParentAt: index),
            parentValue: currentNodeValue
        ) && isValidMinHeap(
            array: array,
            index: HeapHelpers.rightChildIndex(ofParentAt: index),
            parentValue: currentNodeValue
        )
    }
}

