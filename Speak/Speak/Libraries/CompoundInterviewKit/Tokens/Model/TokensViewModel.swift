//
//  TokensViewModel.swift
//  Speak
//
//  Created by Richard Velasquez on 3/21/24.
//

import Foundation
import Combine

final class TokensViewModel: NSObject, ObservableObject {
    private let urlString: String
    @Published var tokens: Tokens? = nil
    private var cancellables: Set<AnyCancellable> = []

    init(
        urlString: String
    ) {
        self.urlString = urlString
        super.init()
        setup()
    }

    private func setup() {
        GenericNetworker.makeRequest(
            urlString: urlString,
            input: nil,
            output: Tokens.self,
            method: "GET"
        ).receive(
            on: DispatchQueue.main
        ).sink { completion in
            return
        } receiveValue: { [weak self] tokens in
            self?.tokens = tokens
        }.store(in: &cancellables)
    }
}
