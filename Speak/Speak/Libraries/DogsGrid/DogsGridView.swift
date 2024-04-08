//
//  DogsGridView.swift
//  Speak
//
//  Created by Richard Velasquez on 4/3/24.
//

import SDWebImage
import SwiftUI
import SDWebImageSwiftUI

struct DogsGridView: View {
    @ObservedObject var viewModel = DogsGridViewModel(
        urlString: "https://dog.ceo/api/breeds/image/random/50"
    )

    private var numberOfColumns = 3

    var body: some View {
        Text(viewModel.dogs?.status ?? "Loading status")
        if let dogs = viewModel.dogs, dogs.message.count > 0 {
            Grid {
                ForEach(0..<numberOfRows(dogsCount: dogs.message.count)) { row in
                    GridRow {
                        ForEach(0..<numberOfColumns) { column in
                            if let urlString = imageURLStringForRow(
                                row: row,
                                column: column,
                                messages: dogs.message
                            ) {
                                dogImage(string: urlString)
                            }
                        }
                    }
                }
            }
        }
    }

    private func numberOfRows(dogsCount: Int) -> Int {
        guard dogsCount > 0 else {
            return 0
        }

        return (dogsCount / numberOfColumns) + ((dogsCount % numberOfColumns > 0) ? 1 : 0 )
    }

    private func imageURLStringForRow(
        row: Int,
        column: Int,
        messages: [String]
    ) -> String? {
        // 0 -> 0, 1, 2, 1 -> 3, 4, 5 2-> 6,7,8 3 ->
        let index = (row * numberOfColumns) + column
        guard index < messages.count else {
            return nil
        }

        return messages[index]
    }

    private func dogImage(string: String) -> some View {
        WebImage(
            url: URL(
                string: string
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

#Preview {
    DogsGridView()
}
