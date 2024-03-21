//
//  FirstCompoundView.swift
//  Speak
//
//  Created by Richard Velasquez on 3/20/24.
//

import Foundation
import SwiftUI

struct FirstCompoundView: View {
    @ObservedObject var viewModel = FirstCompoundViewModel(
        urlString: "https://meowfacts.herokuapp.com"
    )

    var body: some View {
        Text(viewModel.fact ?? "Loading cat fact...")
    }
}

#Preview {
    FirstCompoundView()
}
