//
//  MergeSorter.swift
//  Speak
//
//  Created by Richard Velasquez on 4/10/24.
//

import Foundation


public final class MergeSorter {
    public static func mergeSort<T: Comparable>(
        _ array: [T]
    ) -> [T] {
        //1. Check the array has more than one element
        guard array.count > 1 else {
            return array
        }

        let midPoint = array.count / 2

        //2. Split the array in two and merge sort
        return merge(
            mergeSort(Array(array[..<midPoint])),
            mergeSort(Array(array[midPoint..<array.count]))
        )
    }

    private static func merge<T: Comparable>(
        _ left: [T],
        _ right: [T],
        isFirstPass: Bool = false
    ) -> [T] {
        var leftIndex = 0
        var rightIndex = 0
        var mergedArray = [T]()
        
        while leftIndex < left.count && rightIndex < right.count {
            let leftValue = left[leftIndex]
            let rightValue = right[rightIndex]

            if leftValue < rightValue {
                mergedArray.append(leftValue)
                leftIndex += 1
            } else {
                mergedArray.append(rightValue)
                rightIndex += 1
            }
        }

        var arrayToFinish: ([T], Int)? = leftIndex < left.count
        ? (left, leftIndex)
        : rightIndex < right.count
        ? (right, rightIndex)
        : nil

        if let theArrayToFinish = arrayToFinish {
            var index = theArrayToFinish.1
            while index < theArrayToFinish.0.count {
                mergedArray.append(theArrayToFinish.0[index])
                index += 1
            }
        }

        return mergedArray
    }
}
