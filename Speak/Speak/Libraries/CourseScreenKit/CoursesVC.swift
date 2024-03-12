//
//  CoursesVC.swift
//  Speak
//
//  Created by Richard Velasquez on 3/12/24.
//

import UIKit

final class CoursesVC: UIViewController {
    
    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
    }
    
    // MARK: - View Layout

    private func layoutViews() {
        let testView = UIView(frame: view.bounds)
        testView.backgroundColor = .red

        view.addSubview(testView)
    }
}
