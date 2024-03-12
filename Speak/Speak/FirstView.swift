//
//  ContentView.swift
//  Speak
//
//  Created by Richard Velasquez on 3/12/24.
//

import SwiftUI

struct FirstView: View {
    var body: some View {
        CoursesVCRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    FirstView()
}
