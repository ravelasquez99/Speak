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

    private let dayLabelTop = UILabel()
    private let dayLabelBottom = UILabel()
    var dayNumber: Int? = nil {
        didSet {
            let theDayNumber = dayNumber ?? 0
            var dayString = "\(theDayNumber)"
            if theDayNumber < 10 {
                dayString = "0" + dayString
            }

            dayLabelBottom.text = dayString
            isComplete = dayNumber == 0
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

    var isComplete: Bool? = false {
        didSet {
            dayLabelTop.textColor = SpeakColor.coursesDayToday
            dayLabelBottom.textColor = SpeakColor.coursesDayToday
        }
    }
    
    
    // MARK: - Container Views

    private let dayContainerView = UIView()
    private let dayContainerViewHeight: CGFloat = 40


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
        contentView.addSubview(dayContainerView)

        //Label Setup
        dayContainerView.addSubview(dayLabelTop)
        dayContainerView.addSubview(dayLabelBottom)
        dayLabelTop.adjustsFontSizeToFitWidth = false
        dayLabelTop.minimumScaleFactor = 1
        dayLabelTop.textAlignment = .center
        dayLabelTop.numberOfLines = 1
        dayLabelTop.lineBreakMode = .byTruncatingTail
        dayLabelTop.font = .systemFont(ofSize: 16)
        dayLabelTop.textColor = SpeakColor.coursesDayAndLine
        dayLabelTop.text = "DAY" //TODO Needs localication
        
        dayLabelBottom.adjustsFontSizeToFitWidth = false
        dayLabelBottom.minimumScaleFactor = 1
        dayLabelBottom.textAlignment = .center
        dayLabelBottom.numberOfLines = 1
        dayLabelBottom.lineBreakMode = .byTruncatingTail
        dayLabelBottom.font = .systemFont(ofSize: 30)
        dayLabelBottom.textColor = SpeakColor.coursesDayAndLine

        //Image Setup
        contentView.addSubview(imageAndIconView)
        imageAndIconView.addSubview(dayImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
    }


    // MARK: - Layout

    override public func layoutSubviews() {
        dayContainerView.frame = CGRectMake(
            12,
            contentView.bounds.midY - (dayContainerViewHeight / 2),
            dayContainerViewHeight,
            dayContainerViewHeight
        )

        dayLabelTop.frame = CGRectMake(
            0,
            0,
            dayContainerView.bounds.width,
            floor(dayContainerView.bounds.height / 3)
        )

        dayLabelBottom.frame = CGRectMake(
            0,
            dayLabelTop.frame.maxY,
            dayContainerView.bounds.width,
            dayLabelTop.frame.size.height * 2
        )

        imageAndIconView.frame = CGRectMake(
            dayContainerView.frame.maxX + 15,
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
