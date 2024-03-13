//
//  UnitCell.swift
//  Speak
//
//  Created by Richard Velasquez on 3/13/24.
//

import UIKit

public final class UnitCell: UITableViewCell {


    // MARK: - Variables

    private let unitNumberLabel = UILabel()
    var unitNumber: Int? = nil {
        didSet {
            //TODO localization
            unitNumberLabel.text = "Unit \(unitNumber ?? 0)"
        }
    }

    private let nameLabel = UILabel()
    var unitName: String? = nil {
        didSet {
            nameLabel.text = unitName
        }
    }


    // MARK: - Initialization

    public required init?(
        coder: NSCoder
    ) {
        super.init(coder: coder)
        addAndSetupSubviews()
    }

    override public init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        addAndSetupSubviews()
    }

    private func addAndSetupSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(unitNumberLabel)
    }


    // MARK: - Layout

    override public func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRectMake(
            contentView.bounds.midX - 40,
            contentView.bounds.midY - 20,
            80,
            40
        )

        unitNumberLabel.frame = CGRectMake(
            contentView.bounds.midX - 40,
            nameLabel.bounds.maxY + 5,
            80,
            40
        )
    }
}
