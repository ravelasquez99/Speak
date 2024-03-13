//
//  LocalJsonRetriever.swift
//  Speak
//
//  Created by Richard Velasquez on 3/13/24.
//

import Foundation

public final class LocalJsonRetriever {
    public static func dataFromLocalJson<T: Codable>(
        named name: String,
        modelType: T.Type
    ) -> T? {
        var data: Data?
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let theData = try Data(contentsOf: fileUrl)
                data = theData
            }
        } catch {
            print("error: \(error)")
        }

        guard let theData = data else { return nil }

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: theData)
            return decodedData
        } catch {
            print("error: \(error)")
        }
        
        return nil
    }
}
