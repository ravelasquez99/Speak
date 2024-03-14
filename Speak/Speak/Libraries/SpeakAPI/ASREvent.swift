//
//  ASREvent.swift
//  Speak
//
//  Created by Richard Velasquez on 3/14/24.
//

import Foundation

public struct ASREvent: Codable {
    public let type: ASRType
    public let learningLocale: String?
    public let id: String?
    public let message: String?
    public let recordingId: String?
    public let metadata: ASRMetadata?
    public let chunk: String?
    public let isFinal: Bool?

    public init(
        type: ASRType,
        learningLocale: String? = nil,
        id: String? = nil,
        message: String? = nil,
        recordingId: String? = nil,
        metadata: ASRMetadata? = nil,
        chunk: String? = nil,
        isFinal: Bool? = nil
    ) {
        self.type = type
        self.learningLocale = learningLocale
        self.id = id
        self.message = message
        self.recordingId = recordingId
        self.metadata = metadata
        self.chunk = chunk
        self.isFinal = isFinal
    }
}

public struct ASRMetadata: Codable {
    public let deviceAudio: ASRDeviceAudio?
}

public struct ASRDeviceAudio: Codable {
    public let inputSampleRate: Int?
}

public enum ASRType: String, Codable {
    case asrStart
    case asrMetadata
    case asrError
    case asrClose
    case asrClosed
    case asrStream
    case asrResult
}
