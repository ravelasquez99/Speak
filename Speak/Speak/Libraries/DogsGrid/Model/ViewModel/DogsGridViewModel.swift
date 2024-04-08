//
//  DogsGridViewModel.swift
//  Speak
//
//  Created by Richard Velasquez on 4/3/24.
//

import Combine
import Foundation

final class DogsGridViewModel: ObservableObject {
    let urlString: String
    @Published var dogs: Dogs? = nil
    var cancellables =  [AnyCancellable]()

    init(urlString: String) {
        self.urlString = urlString
        setup()
    }

    private func setup() {
        GenericNetworker.makeRequest(
            urlString: urlString,
            input: nil,
            method: "GET"
        ).receive(
            on: DispatchQueue.main
        ).replaceError(
            with: Dogs(message: [], status: "FAILED")
        ).sink { [weak self] (dogs: Dogs) in
            self?.dogs = dogs
        }.store(in: &cancellables)
    }
}
