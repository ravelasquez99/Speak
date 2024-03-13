//
//  CoursesVCRepresentable.swift
//  Speak
//
//  Created by Richard Velasquez on 3/12/24.
//

import SwiftUI
import UIKit

struct CoursesVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(
        context: Context
    ) -> CoursesVC {
        guard let course = LocalJsonRetriever.dataFromLocalJson(
            named: "course",
            modelType: Course.self
        ) else {
            fatalError("No course json")
        }

        return CoursesVC(course: course)
    }
    
    func updateUIViewController(
        _ uiViewController: CoursesVC,
        context: Context
    ) {
        //tbd
    }
}
