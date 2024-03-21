//
//  Tokens.swift
//  Speak
//
//  Created by Richard Velasquez on 3/21/24.
//

import Foundation


// MARK: - Tokens

struct Tokens: Codable {
    let assets: [Token]
}


// MARK: - Asset

struct Token: Codable, Identifiable {
    var id: String {
        return symbol
    }
    
    let name: String
    let symbol: String
    let image: String
    let price: Double
    let totalSupply: Int
    let collateralFactor: Int
    let liquidationFactor: Int

    enum CodingKeys: String, CodingKey {
        case name, symbol, image, price
        case totalSupply = "total_supply"
        case collateralFactor = "collateral_factor"
        case liquidationFactor = "liquidation_factor"
    }

    static func demoToken(symbol: String) -> Self {
        return .init(
            name: "Wrapped Bitcoin",
            symbol: symbol,
            image: "https://s2.coinmarketcap.com/static/img/coins/64x64/3717.png",
            price: 27014.8701,
            totalSupply: 212350000,
            collateralFactor: 70,
            liquidationFactor: 80
        )
    }
}
