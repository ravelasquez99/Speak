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
        unitsTableView.backgroundColor = .clear
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
        unitsTableView.sectionHeaderTopPadding = 0

        //Setup
        unitsTableView.dataSource = self
        unitsTableView.delegate = self

        unitsTableView.register(
            DayCell.self,
            forCellReuseIdentifier: Self.dayCellReuseIdentifier
        )

        unitsTableView.register(
            UnitCell.self,
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
        return ceil(view.bounds.height * 0.15)
    }

    private func dayCellHeight() -> CGFloat {
        return 140
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
        guard let unitCell = tableView.dequeueReusableCell(
            withIdentifier: Self.unitCelllReuseIdentifier
        ) as? UnitCell else {
            fatalError("Could not dequeue header view")
        }

        unitCell.unitNumber = indexPath.section + 1
        // using id because there is no unit name in the json
        unitCell.unitName = course.units[indexPath.section].id
        return unitCell
    }

    private func dayCell(
        tableView: UITableView,
        indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Self.dayCellReuseIdentifier,
            for: indexPath
        ) as? DayCell
        else {
            fatalError("Could not dequeue day cell")
        }

        // Normally I would check the array size.
        let dayNumber = indexPath.row - 1 // to account for unit cell
        let day = course
            .units[indexPath.section]
            .days[dayNumber]
        
        /* 
         If I had more time you need an algo here because the first day in unit 2
         is not day 0. It Is day (number of days in unit 1 + 1)
         You'd also need to account for units with no days, etc
        */
        cell.dayNumber = dayNumber
        cell.title = day.title
        cell.subtitle = day.subtitle
        cell.thumbnailImageURL = day.thumbnailImageURL
        cell.isComplete = dayNumber == 0 // This data is missing from the model

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return indexPath.row == 0 ? unitHeaderHeight() : dayCellHeight()
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

