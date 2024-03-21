//
//  TokensCardView.swift
//  Speak
//
//  Created by Richard Velasquez on 3/21/24.
//

import Foundation
import Foundation
import SwiftUI

struct TokensCardView: View {
    let tokens: Tokens

    var body: some View {
        if !tokens.assets.isEmpty {
            //TODO - card, list etc, handle tap states
            VStack {
                ForEach(tokens.assets) { token in
                    TokenView(token: token)
                }
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    TokensCardView(
        tokens: .init(
            assets: [
                .demoToken(symbol: "WBTC"),
                .demoToken(symbol: "WBTC1"),
                .demoToken(symbol: "WBTC2"),
                .demoToken(symbol: "WBTC3")
            ]
        )
    )
}
