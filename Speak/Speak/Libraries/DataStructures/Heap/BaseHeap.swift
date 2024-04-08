//
//  BaseHeap.swift
//  Speak
//
//  Created by Richard Velasquez on 4/8/24.
//

import Foundation

public class BaseHeap<T: Comparable>: Heaping {


    // MARK: - API

    required public init(array: [T]) {
        self.heap = array
        Self.initialHeapify(array: &self.heap)
    }
    
    public var isEmpty: Bool {
        return heap.isEmpty
    }
    
    public var count: Int {
        return heap.count
    }
    
    public func insert(_ value: T) {
        heap.append(value)
        heapifyUp(array: &heap)
    }
    
    public func extractTop() -> T? {
        guard !isEmpty else {
            return nil
        }

        // put the last element at the top
        heap.swapAt(0, heap.count - 1)

        // remove the min value (which we moved to the end of the array)
        let currentMin = heap.popLast()

        // heapify down
        Self.heapifyDown(&heap, fromIndex: 0)

        // Retunr the min value
        return currentMin
    }

    public func peek() -> T? {
        guard heap.count > 0 else {
            return nil
        }

        return heap[0]
    }
    
    public typealias Item = T
    
    
    // MARK: - iVars

    public var heap: [T]
    
    
    // MARK: - Implementation

    private static func initialHeapify(array: inout [T]) {
        guard array.count > 0 else {
            return
        }

        guard let startIndex = HeapHelpers.parentIndex(
            ofChildAt: array.count - 1
        ) else {
            return
        }
        // start at the last non leaf node. get it sorted downwards(heapify down), then traverse backwards in the heap
        for index in (0...startIndex).reversed() {
            Self.heapifyDown(
                &array,
                fromIndex: index
            )
        }
    }

    private static func heapifyDown(
        _ array: inout [T],
        fromIndex index: Int
    ) {
        // get the parent index
        var parentIndex = index
        
        // Start sorting
        while true {
            // Grab left child, right child, and "smallest" index which currently the parent index
            let leftChildIndex = HeapHelpers.leftChildIndex(ofParentAt: parentIndex)
            let rightChildIndex = leftChildIndex + 1
            var smallestIndex = parentIndex
            
            // if the left child is in the array, and should be higher than the highest index, the highest is now left
            if leftChildIndex < array.count && aShouldBeCloserToTop(a: array[leftChildIndex], b: array[smallestIndex]) {
                smallestIndex = leftChildIndex
            }
            
            // if the right child is in the array and higher than the highest index then the right is the highest
            if rightChildIndex < array.count && aShouldBeCloserToTop(a: array[rightChildIndex], b: array[smallestIndex]) {
                smallestIndex = rightChildIndex
            }
            
            // if the smallest is the parent we're done and this is sorted correctly
            if smallestIndex == parentIndex {
                break
            }
            
            // otherwise swap the parent with the smallest child and move down the graph
            array.swapAt(parentIndex, smallestIndex)
            parentIndex = smallestIndex
        }
    }

    private func heapifyUp(array: inout [T]) {
        var nodeIndex = array.count - 1
        while true {
            guard let parentIndex = HeapHelpers.parentIndex(ofChildAt: nodeIndex) else {
                nodeIndex = -1
                break
            }

            let currentValue = array[nodeIndex]
            let parentValue = array[parentIndex]
            if Self.aShouldBeCloserToTop(a: currentValue, b: parentValue) {
                array.swapAt(nodeIndex, parentIndex)
            }
            
            nodeIndex = parentIndex
        }
    }

    open class func aShouldBeCloserToTop(a: Item, b: Item) -> Bool {
        fatalError("should be implemented by subclass")
    }
}
