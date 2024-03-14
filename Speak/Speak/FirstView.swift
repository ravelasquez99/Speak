//
//  ContentView.swift
//  Speak
//
//  Created by Richard Velasquez on 3/12/24.
//

import SwiftUI

struct FirstView: View {
    @State private var navPath = NavigationPath()
    @State private var selectedDay: Day? = nil
    var body: some View {
        NavigationStack(path: $navPath) {
            CoursesVCRepresentable(onDidTapDay: { day in
                navPath.append(day)
            })
            .edgesIgnoringSafeArea(.all)
            .navigationDestination(for: Day.self) { day in
                RecordView()
            }
        }
    }
}

#Preview {
    FirstView()
}
