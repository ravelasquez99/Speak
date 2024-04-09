//
//  Heap.swift
//  Speak
//
//  Created by Richard Velasquez on 4/3/24.
//

import Foundation


public final class MaxHeap<T: Comparable>: BaseHeap<T> {
    override class public func aShouldBeCloserToTop(a: BaseHeap<T>.Item, b: BaseHeap<T>.Item) -> Bool {
        return a > b
    }
}

public final class MinHeap<T: Comparable>: BaseHeap<T> {
    override class public func aShouldBeCloserToTop(a: BaseHeap<T>.Item, b: BaseHeap<T>.Item) -> Bool {
        return a < b
    }
}


