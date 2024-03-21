//
//  TokenView.swift
//  Speak
//
//  Created by Richard Velasquez on 3/21/24.
//

import SDWebImage
import SwiftUI
import SDWebImageSwiftUI

struct TokenView: View {
    let token: Token
    @State var expanded: (Bool) = false

    var body: some View {
        Button(action: {
            withAnimation {
                expanded.toggle()
            }
        }, label: {
            VStack {
                HStack {
                    tokenImage
                    VStack(
                        alignment: .leading,
                        content: {
                            Text(token.name)
                            Text(token.symbol)
                        }
                    )
                    Spacer()
                    Text("$\(token.totalSupply)")
                }

                if expanded {
                    VStack {
                        Divider()
                        TokenViewBodyRowView(itemType: .oraclePrice(price: token.price))
                        TokenViewBodyRowView(itemType: .collateralFactor(collateralFactor: token.collateralFactor))
                        TokenViewBodyRowView(itemType: .liquidationFactor(liquidationFactor: token.liquidationFactor))
                    }
                }
            }
        })
        .padding()
    }

    private var tokenImage: some View {
        WebImage(
            url: URL(
                string: token.image
            )
        ) { image in
            image.resizable()
        } placeholder: {
            Circle()
        }
        .transition(.fade(duration: 0.5)) // Fade Transition with duration
        .scaledToFit()
        .frame(width: 40, height: 40)
    }
}

struct TokenViewBodyRowView: View {
    enum ItemType {
        case oraclePrice(price: Double)
        case collateralFactor(collateralFactor: Int)
        case liquidationFactor(liquidationFactor: Int)
    }

    let itemType: ItemType
    
    var body: some View {
        HStack {
            Text(lhsText)
            Spacer()
            Text(rhsText)
        }
    }

    var lhsText: String {
        switch itemType {
        case .oraclePrice(_):
            return "Oracle Price"
        case .collateralFactor(_):
            return "Collateral Factor"
        case .liquidationFactor(_):
            return "Liquidation Factor"
        }
    }

    var rhsText: String {
        switch itemType {
        case .oraclePrice(let price):
            return "$\(Double(round(100 * price) / 100))"
        case .collateralFactor(let collateralFactor):
            return "\(collateralFactor)%"
        case .liquidationFactor(let liquidationFactor):
            return "\(liquidationFactor)%"
        }
    }
}

#Preview {
    TokenView(token: .demoToken(symbol: "WBTC"))
}
