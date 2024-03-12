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
        return CoursesVC()
    }
    
    func updateUIViewController(
        _ uiViewController: CoursesVC,
        context: Context
    ) {
        //tbd
    }
}
