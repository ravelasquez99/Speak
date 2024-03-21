//
//  TokensView.swift
//  Speak
//
//  Created by Richard Velasquez on 3/21/24.
//

import Foundation
import SwiftUI

struct TokensView: View {
    @ObservedObject var viewModel = TokensViewModel(
        urlString: "https://alexandfox.github.io/api/markets-data.json"
    )

    var body: some View {
        if let tokens = viewModel.tokens {
            TokensCardView(tokens: tokens)
            Spacer()
        } else {
            Text("Loading Tokens..")
        }
    }
}

#Preview {
    TokensView()
}
