//
//  RadixSorter.swift
//  Speak
//
//  Created by Richard Velasquez on 4/9/24.
//

import Foundation

public final class RadixSorter {
    public static func sort<T: Intable>(_ array: inout [T]) {
        //1. Get the max value of the array
        guard let maxNumber = array.max() else {
            return
        }

        //2. Start at (0-9)
        var current10Place = 1

        //3. Start looping until we have exceeded the max valu in the array
        while current10Place <= maxNumber.intValue {
            //Loop - 1. Build array of arrays for each 10 base 10 numbers (0,1,2,3,4,5,6,7,8,9)
            var buckets: [[T]] = .init(repeating: [], count: 10)

            // Loop - 2. Enumerate the array
            for number in array  {
                // For Loop - 1. Grab the digit (0-9) by dividing the value by the current 10 place then % 10
                // ex if current10Place is 100 and the number is 987. (987/100) = 9. 9 % 10 = 9.
                // so we'd add it to the 9 place
                // Sorting within the array does not matter as it will all be sorted at the end
                let digit = (number.intValue / current10Place) % 10
                buckets[digit].append(number)
            }
            
            // Loop - 3. Flatten the array back into place
            array = buckets.flatMap({$0})

            // Increment then current 10 place by multiplying it by 10
            current10Place *= 10
        }
    }
}

public protocol Intable: Comparable {
    var intValue: Int  { get }
}

extension Int: Intable {
    public var intValue: Int {
        return self
    }
}
