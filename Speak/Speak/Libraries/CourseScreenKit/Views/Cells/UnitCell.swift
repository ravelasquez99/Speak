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
    private let unitNumberLabelFont = UIFont.boldSystemFont(ofSize: 28) //Magic number without design file
    var unitNumber: Int? = nil {
        didSet {
            //TODO localization
            unitNumberLabel.text = "Unit \(unitNumber ?? 0)"
        }
    }

    private let nameLabel = UILabel()
    private let nameLabelStyle: UIFont.TextStyle = .subheadline
    var unitName: String? = nil {
        didSet {
            nameLabel.text = "\(unitName ?? "") subtitle (N/A)"
        }
    }

    private let iconImageView = UIImageView()


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
        contentView.addSubview(iconImageView)

        contentView.backgroundColor = UIColor.clear
        self.backgroundColor = .clear

        iconImageView.image = UIImage(named: "course-unit-default-icon")
        iconImageView.contentMode = .scaleAspectFill
        
        unitNumberLabel.adjustsFontSizeToFitWidth = true
        unitNumberLabel.minimumScaleFactor = 0.6
        unitNumberLabel.textAlignment = .center
        unitNumberLabel.numberOfLines = 1
        unitNumberLabel.lineBreakMode = .byTruncatingTail
        unitNumberLabel.font = unitNumberLabelFont
        unitNumberLabel.textColor = SpeakColor.unitTitleText
        
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.6
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 1
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.font = .preferredFont(forTextStyle: nameLabelStyle)
        nameLabel.textColor = SpeakColor.unitTitleText
    }


    // MARK: - Layout

    override public func layoutSubviews() {
        super.layoutSubviews()
        let middleX = contentView.bounds.midX

        let imageWidthAndHeight = CGFloat(50.0)
        iconImageView.frame = CGRectMake(
            middleX - (imageWidthAndHeight / 2),
            0,
            imageWidthAndHeight,
            imageWidthAndHeight
        )

        iconImageView.layer.cornerRadius = imageWidthAndHeight / 2
        iconImageView.clipsToBounds = true

        if let unitNumberLabelText = unitNumberLabel.text as? NSString {
            let nameLabelAttributes: [NSAttributedString.Key: Any] = [
                .font: unitNumberLabelFont
            ]

            let calloutSize = unitNumberLabelText
                .size(withAttributes: nameLabelAttributes)

            unitNumberLabel.frame = CGRectMake(
                middleX - (calloutSize.width / 2),
                iconImageView.frame.maxY + 10, //magic number with no layout file
                calloutSize.width,
                calloutSize.height
            )
        }

        if let nameLabelText = nameLabel.text as? NSString {
            let nameLabelAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.preferredFont(forTextStyle: nameLabelStyle)
            ]

            let calloutSize = nameLabelText
                .size(withAttributes: nameLabelAttributes)

            nameLabel.frame = CGRectMake(
                middleX - (calloutSize.width / 2),
                unitNumberLabel.frame.maxY + 2, //magic number with no layout file
                calloutSize.width,
                calloutSize.height
            )
        }
        
//
//        unitNumberLabel.frame = CGRectMake(
//            contentView.bounds.midX - 40,
//            nameLabel.bounds.maxY + 5,
//            80,
//            40
//        )
    }
}
