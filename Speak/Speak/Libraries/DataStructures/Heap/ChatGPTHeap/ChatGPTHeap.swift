//
//  ChatGPTHeap.swift
//  Speak
//
//  Created by Richard Velasquez on 4/3/24.
//

import Foundation



public class ChatGPTMinHeap<T: Comparable>: Heaping {
    public var heap: [T] = []

    public var isEmpty: Bool {
        return heap.isEmpty
    }

    public var count: Int {
        return heap.count
    }

    private func parentIndex(ofChildAt index: Int) -> Int {
        return (index - 1) / 2
    }

    private static func leftChildIndex(ofParentAt index: Int) -> Int {
        return 2 * index + 1
    }

    private static func rightChildIndex(ofParentAt index: Int) -> Int {
        return 2 * index + 2
    }

    private func heapifyUp(from index: Int) {
        var childIndex = index
        let child = heap[childIndex]
        var parentIndex = self.parentIndex(ofChildAt: childIndex)

        while childIndex > 0 && child < heap[parentIndex] {
            heap[childIndex] = heap[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(ofChildAt: childIndex)
        }

        heap[childIndex] = child
    }

    public func insert(_ value: T) {
        heap.append(value)
        heapifyUp(from: heap.count - 1)
    }

    public func extractTop() -> T? {
        guard !heap.isEmpty else { return nil }
        if heap.count == 1 {
            return heap.removeLast()
        } else {
            let min = heap[0]
            heap[0] = heap.removeLast()
            heapifyDown(from: 0)
            return min
        }
    }

    public func peek() -> T? {
        return heap.first
    }

    required public init(array: [T]) {
        let startIndex = (array.count / 2) - 1 // Start with the last non-leaf node
        var theArray = array
        
        for index in (0...startIndex).reversed() {
            print("chatgptminheap index is \(index) and value is \(array[index])")
            Self.heapifyDownForArrayHeapify(
                &theArray,
                fromIndex: index,
                upTo: array.count
            )
        }

        self.heap = theArray
    }

    private static func heapifyDownForArrayHeapify(
        _ array: inout [T],
        fromIndex index: Int,
        upTo size: Int
    ) {
        var parentIndex = index
        
        while true {
            let leftChildIndex = Self.leftChildIndex(ofParentAt: parentIndex)
            let rightChildIndex = leftChildIndex + 1
            var smallestIndex = parentIndex
            
            if leftChildIndex < size && array[leftChildIndex] < array[smallestIndex] {
                smallestIndex = leftChildIndex
            }
            
            if rightChildIndex < size && array[rightChildIndex] < array[smallestIndex] {
                smallestIndex = rightChildIndex
            }
            
            if smallestIndex == parentIndex {
                break
            }

            array.swapAt(parentIndex, smallestIndex)
            parentIndex = smallestIndex
        }
    }

    private func heapifyDown(from index: Int) {
        var parentIndex = index
        while true {
            let leftChildIndex = Self.leftChildIndex(ofParentAt: parentIndex)
            let rightChildIndex = leftChildIndex + 1

            var optionalParentSwapIndex: Int?

            if leftChildIndex < heap.count && heap[leftChildIndex] < heap[parentIndex] {
                optionalParentSwapIndex = leftChildIndex
            }

            if rightChildIndex < heap.count
                && heap[rightChildIndex] < (optionalParentSwapIndex == nil ? heap[parentIndex] : heap[leftChildIndex]) {
                optionalParentSwapIndex = rightChildIndex
            }

            guard let parentSwapIndex = optionalParentSwapIndex else { return }

            heap.swapAt(parentIndex, parentSwapIndex)
            parentIndex = parentSwapIndex
        }
    }
}
