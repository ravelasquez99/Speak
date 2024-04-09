//
//  QuickSort.swift
//  Speak
//
//  Created by Richard Velasquez on 4/9/24.
//

import Foundation

public final class QuickSorter {
    public static func sort<T: Comparable>(_ array: inout [T]) {
        quickSort(&array, low: 0, high: array.count - 1)
    }
    
    private static func quickSort<T: Comparable>(
        _ array: inout [T],
        low: Int,
        high: Int
    ) {
        //1. If Low > high we are done
        guard low < high else {
            return
        }

        //2. Grab the pivot index (using median of three method)
        let pivotIndex = medianIndexOfThree(array, low: low, high: high)

        //3. Get the new index of the pivot as the partition point
        let partitionIndex = partition(&array, low: low, high: high, pivotIndex: pivotIndex)
        
        //4. Do it again splitting the array left and right of the particion
        quickSort(&array, low: low, high: partitionIndex - 1)
        quickSort(&array, low: partitionIndex + 1, high: high)
    }

    private static func medianIndexOfThree<T: Comparable>(
        _ array: [T],
        low: Int,
        high: Int
    ) -> Int {
        //1. Build Middle tuple
        let middleIndex = (low + (high - low) / 2)
        let middleValue = array[middleIndex]
        let sorted = [
            (low, array[low]),
            (middleIndex, middleValue),
            (high, array[high])
        ].sorted(by: {$0.1 < $1.1})

        return sorted[1].0
    }

    private static func partition<T: Comparable>(
        _ array: inout [T],
        low: Int,
        high: Int,
        pivotIndex: Int
    ) -> Int {
        //1. Move pivot to the end
        let pivotValue = array[pivotIndex]
        array.swapAt(pivotIndex, high)

        //2. Enumerate the array from low to high (not including high as that is our pivot value)
        var indexToPlaceNextLowerValue = low
        for i in low..<high {
            // For loop 1. - If current index is less than the value put it at the front of the current low
            // And increment the current low.
            if array[i] < pivotValue {
                array.swapAt(i, indexToPlaceNextLowerValue)
                indexToPlaceNextLowerValue += 1
            }
        }
        
        // 3. Place the pivot value at the currentLow as everything to the left is lower than it
        array.swapAt(indexToPlaceNextLowerValue, high) // Move pivot to its final place

        //4. Return the place we put it.
        return indexToPlaceNextLowerValue
    }
}

