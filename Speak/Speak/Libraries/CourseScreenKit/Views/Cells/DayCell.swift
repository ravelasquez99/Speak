//
//  DayCell.swift
//  Speak
//
//  Created by Richard Velasquez on 3/13/24.
//

import SDWebImage
import UIKit

public final class DayCell: UITableViewCell {


    // MARK: - Variables

    private let dayLabel = UILabel()
    var dayNumber: Int? = nil {
        didSet {
            dayLabel.text = "Day \(dayNumber ?? 0)"
        }
    }

    private let titleLabel = UILabel()
    var title: String? = nil {
        didSet {
            titleLabel.text = title
        }
    }

    private let subtitleLabel = UILabel()
    var subtitle: String? = nil {
        didSet {
            subtitleLabel.text = subtitle
        }
    }

    private let imageAndIconView = UIView()
    private let dayImageView = UIImageView()
    var thumbnailImageURL: String? = nil {
        didSet {
            guard let urlString = thumbnailImageURL else {
                dayImageView.sd_cancelCurrentImageLoad()
                dayImageView.image = nil
                return
            }

            dayImageView.sd_setImage(
                with: URL(string: urlString)
            )
        }
    }

    var isComplete: Bool? = false


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
        setup()
        addAndSetupSubviews()
    }

    private func setup() {
        contentView.backgroundColor = UIColor.clear
        self.backgroundColor = .clear
    }

    private func addAndSetupSubviews() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(imageAndIconView)
        imageAndIconView.addSubview(dayImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
    }


    // MARK: - Layout

    override public func layoutSubviews() {
        super.layoutSubviews()
        dayLabel.frame = CGRectMake(
            12,
            contentView.bounds.midY - 40,
            80,
            20
        )

        imageAndIconView.frame = CGRectMake(
            dayLabel.frame.maxX + 15,
            contentView.bounds.midY - 20,
            40,
            40
        )
        dayImageView.frame = imageAndIconView.bounds

        titleLabel.frame = CGRectMake(
            imageAndIconView.frame.maxX + 15,
            contentView.bounds.midY - 20,
            400,
            40
        )

        subtitleLabel.frame = CGRectMake(
            imageAndIconView.frame.maxX + 15,
            titleLabel.frame.maxY + 4,
            300,
            40
        )
    }
}
