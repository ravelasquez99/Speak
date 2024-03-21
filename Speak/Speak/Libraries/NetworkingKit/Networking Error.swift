//
//  Networking Error.swift
//  Speak
//
//  Created by Richard Velasquez on 3/20/24.
//

import Foundation

public enum NewtworkingError: Error {
    case urlError
    case encodingError(Error)
    case decodingError(Error)
}
