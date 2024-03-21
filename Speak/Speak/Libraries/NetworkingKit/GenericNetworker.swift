//
//  GenericNetworker.swift
//  Speak
//
//  Created by Richard Velasquez on 3/20/24.
//

import Foundation
import Combine

public final class GenericNetworker: ObservableObject {
    public static func makeRequest<V: Codable>(
        urlString: String,
        input: Codable?,
        output: V.Type,
        method: String
    ) -> AnyPublisher<V, NewtworkingError> {
        guard let url = URL(
            string: urlString
        ) else {
            return Fail(
                error: NewtworkingError.urlError
            ).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            if let theInput = input {
                let jsonData = try JSONEncoder().encode(theInput)
                request.httpBody = jsonData
            }
        } catch {
            return Fail(
                error: .encodingError(error)
            ).eraseToAnyPublisher()
        }

        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .map(\.data).map({ data -> Data in
                return data
            })
            .decode(type: V.self, decoder: JSONDecoder())
            .mapError({ theError in
                return .decodingError(theError)
            })
            .eraseToAnyPublisher()
    }
}
