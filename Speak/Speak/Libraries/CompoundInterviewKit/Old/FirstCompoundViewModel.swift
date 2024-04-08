//
//  FirstCompoundViewModel.swift
//  Speak
//
//  Created by Richard Velasquez on 3/20/24.
//

import Combine
import Foundation

public final class FirstCompoundViewModel: NSObject, ObservableObject {
    private let urlString: String
    @Published public var fact: String? = nil
    private var cancellables: Set<AnyCancellable> = []

    public init(
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
            method: "GET"
        ).receive(
            on: DispatchQueue.main
        ).sink { completion in
            return
        } receiveValue: { (facts: CatFacts) in
            self.fact = facts.data.first
        }.store(in: &cancellables)
    }
}
