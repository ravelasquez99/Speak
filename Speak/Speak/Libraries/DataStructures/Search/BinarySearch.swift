//
//  BinarySearch.swift
//  Speak
//
//  Created by Richard Velasquez on 4/10/24.
//

import Foundation

public final class BinarySearcher {
    public static func findElement<T: Comparable>(
        _ element: T,
        in array: [T]
    ) -> Int? {
        guard array.count > 0 else { return nil }

        var currentMinIndex = 0
        var currentMaxIndex = array.count - 1

        while currentMinIndex <= currentMaxIndex {
            let currentIndex = currentMinIndex + ((currentMaxIndex - currentMinIndex) / 2)
            let value = array[currentIndex]
            if value == element  {
                return currentIndex
            }

            if value < element {
                // we need to down up the array
                currentMinIndex = currentIndex + 1
            } else {
                // We need to move up the array
                currentMaxIndex = currentIndex - 1
            }
        }

        return nil
    }
}
