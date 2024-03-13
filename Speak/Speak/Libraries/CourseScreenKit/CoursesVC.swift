//
//  CoursesVC.swift
//  Speak
//
//  Created by Richard Velasquez on 3/12/24.
//

import UIKit

final class CoursesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {


    // MARK: - Variables

    let course: Course
    let unitsTableView = UITableView(frame: .zero, style: .plain)
    private static let unitCelllReuseIdentifier = "unitSectionHeaderReuseIdentifier"
    private static let dayCellReuseIdentifier = "dayCellReuseIdentifier"


    // MARK: - Init

    init(course: Course) {
        self.course = course
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - VC Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupUnitsTableView()
        view.backgroundColor = SpeakColor.standardViewBackground
        unitsTableView.backgroundColor = .purple
    }


    // MARK: - View Layout/Setup

    private func setupUnitsTableView() {
        //Layout
        unitsTableView.frame = CGRectMake(
            0,
            heroHeaderHeight(),
            view.bounds.width,
            view.bounds.height - heroHeaderHeight()
        )
        unitsTableView.sectionHeaderTopPadding = 0 //rickyv123 remove

        //Color
        unitsTableView.layer.borderWidth = 1.0
        unitsTableView.layer.borderColor = UIColor.red.cgColor

        //Setup
        unitsTableView.dataSource = self
        unitsTableView.delegate = self

        unitsTableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: Self.dayCellReuseIdentifier
        )

        unitsTableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: Self.unitCelllReuseIdentifier
        )

        //Add to view
        view.addSubview(unitsTableView)
    }

    private func setupHeader() {
        let tableHeaderView = heroHeaderView()
        tableHeaderView.frame = CGRect(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: heroHeaderHeight()
        )

        view.addSubview(tableHeaderView)
    }

    private func heroHeaderHeight() -> CGFloat {
        //magic number with no layout file
        return floor(view.bounds.height * 0.33) + view.safeAreaInsets.top
    }

    private func unitHeaderHeight() -> CGFloat {
        return 100
    }

    private func dayCellHeight() -> CGFloat {
        return 90
    }


    // MARK: - TableView Sections DS

    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        return numberOfUnits()
    }


    // MARK: - TableView Cells DS

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return numberOfDaysInUnit(section) + 1 // the unit header is a cell
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        return indexPath.row == 0
        ? unitCell(tableView: tableView, indexPath: indexPath)
        : dayCell(tableView: tableView, indexPath: indexPath)
    }

    private func unitCell(
        tableView: UITableView,
        indexPath: IndexPath
    ) -> UITableViewCell {
        guard let view = tableView.dequeueReusableCell(
            withIdentifier: Self.unitCelllReuseIdentifier
        ) else {
            fatalError("Could not dequeue header view")
        }

        let index = indexPath.section
        let colors: [UIColor] = [.blue, .red, .orange, .gray, .purple, .black]
        view.contentView.backgroundColor = colors[index] //TODO
        return view
    }

    private func dayCell(
        tableView: UITableView,
        indexPath: IndexPath
    ) -> UITableViewCell {
        //TODO remember index + 1 to account for unit cell
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Self.dayCellReuseIdentifier,
            for: indexPath
        )

        cell.contentView.backgroundColor = .green
        cell.contentView.layer.borderColor = UIColor.orange.cgColor //TODO
        cell.contentView.layer.borderWidth = 1

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return dayCellHeight()
    }


    // MARK: - UITableView Delegate
    
    //TODO


    // MARK: - Model Logic

    private func numberOfDaysInUnit(_ unitIndex: Int) -> Int {
        guard unitIndex < course.units.count else {
            return 0
        }

        let unit = course.units[unitIndex]
        return unit.days.count
    }

    private func numberOfUnits() -> Int {
        return course.units.count
    }


    // MARK: - Header View Building

    private func heroHeaderView() -> UIView {
        return CoursesHeroHeaderView(
            frame: CGRectMake(
                0,
                0,
                view.bounds.width,
                heroHeaderHeight()
            ),
            bannerImageName: "course-default-header-background",
            circleImageURLString: course.info.thumbnailImageURL,
            heroText: course.info.title,
            calloutText: course.info.subtitle
        )
    }
}

