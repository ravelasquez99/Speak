//
//  HeapHelpers.swift
//  Speak
//
//  Created by Richard Velasquez on 4/8/24.
//

import Foundation

public class HeapHelpers {
    public static func parentIndex(ofChildAt index: Int) -> Int? {
        return index <= 0 ? nil : (index - 1) / 2
    }

    public static func leftChildIndex(ofParentAt index: Int) -> Int {
        return index * 2 + 1
    }

    public static func rightChildIndex(ofParentAt index: Int) -> Int {
        return leftChildIndex(ofParentAt: index) + 1
    }
}
