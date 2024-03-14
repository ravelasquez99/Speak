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
    private let iconView = UIImageView()

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

    var isComplete: Bool = false {
        didSet {
            dayLabelTop.textColor = isComplete
            ? SpeakColor.coursesDayToday
            : SpeakColor.coursesDayAndLine
            dayLabelBottom.textColor = isComplete
            ? SpeakColor.coursesDayToday
            : SpeakColor.coursesDayAndLine
        }
    }


    // MARK: - Container Views

    private let dayContainerView = UIView()
    private let dayContainerViewHeight: CGFloat = 40
    
    private let dataContainerView = UIView()
    private let dataContainerViewHeight: CGFloat = 40


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

        //Data container Setup
        
        contentView.addSubview(dataContainerView)
        dataContainerView.backgroundColor = SpeakColor.white
        dataContainerView.layer.cornerRadius = 16
        dataContainerView.clipsToBounds = true

        //Image & Icon setup
        dataContainerView.addSubview(imageAndIconView)
        imageAndIconView.addSubview(dayImageView)
        dayImageView.contentMode = .scaleAspectFill
        dayImageView.layer.borderWidth = 4 // Using layers can sometimes be bad for performance
        dayImageView.layer.borderColor = SpeakColor.coursesImageCircle.cgColor

        //Title and subtitle labels
        dataContainerView.addSubview(titleLabel)
        dataContainerView.addSubview(subtitleLabel)

        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.minimumScaleFactor = 1 // Not good for accesibility
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = SpeakColor.coursesTitle

        subtitleLabel.adjustsFontSizeToFitWidth = false
        subtitleLabel.minimumScaleFactor = 0.75 // Not good for accesibility
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 2
        subtitleLabel.lineBreakMode = .byTruncatingTail
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = SpeakColor.coursesDayAndLine
    }


    // MARK: - Layout

    override public func layoutSubviews() {
        // Layout day view
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

        // Layout data container view
        let dataContainerHeight = floor(contentView.bounds.height * 0.95)
        dataContainerView.frame = CGRectMake(
            dayContainerView.frame.maxX + 12,
            (contentView.bounds.height - dataContainerHeight) / 2,
            floor(contentView.bounds.width * 0.8),
            dataContainerHeight
        )

        imageAndIconView.frame = CGRectMake(
            15,
            dataContainerView.bounds.midY - 40,
            80,
            80
        )
        dayImageView.frame = imageAndIconView.bounds
        dayImageView.layer.cornerRadius = dayImageView.bounds.width / 2
        dayImageView.clipsToBounds = true

        titleLabel.frame = CGRectMake(
            dayImageView.frame.maxX + 30,
            (dataContainerHeight / 2) - 20,
            dataContainerView.bounds.width
            - dayImageView.frame.width
            - 30 //padding for image on each side
            - 15, // keeping even padding on right side
            20
        )

        subtitleLabel.frame = CGRectMake(
            dayImageView.frame.maxX + 30,
            (dataContainerHeight / 2),
            dataContainerView.bounds.width
            - dayImageView.frame.width
            - 30 //padding for image on each side
            - 15, // keeping even padding on right side,
            40
        )
    }
}
