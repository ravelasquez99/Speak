//
//  Course.swift
//  Speak
//
//  Created by Richard Velasquez on 3/13/24.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:

// MARK: - Course
struct Course: Codable {
    let id: String
    let info: Info
    let units: [Unit]
}

// MARK: - Info
struct Info: Codable {
    let title: String
    let thumbnailImageURL: String
    let subtitle: String

    enum CodingKeys: String, CodingKey {
        case title
        case thumbnailImageURL = "thumbnailImageUrl"
        case subtitle
    }
}

// MARK: - Unit
struct Unit: Codable {
    let id: String
    let days: [Day]
}

// MARK: - Day
struct Day: Codable, Hashable {
    static func == (
        lhs: Day,
        rhs: Day
    ) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id, title: String
    let thumbnailImageURL: String
    let subtitle: String
    let lessons: [Lesson]?

    enum CodingKeys: String, CodingKey {
        case id, title
        case thumbnailImageURL = "thumbnailImageUrl"
        case subtitle, lessons
    }
}

// MARK: - Lesson
struct Lesson: Codable, Hashable {
    let id, title: String
    let durationMin: Int
}
