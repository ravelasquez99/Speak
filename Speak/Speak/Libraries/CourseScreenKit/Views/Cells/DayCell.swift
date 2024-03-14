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
        dayImageView.layer.borderWidth = 2 // Using layers can sometimes be bad for performance
        dayImageView.layer.borderColor = SpeakColor.coursesImageCircle.cgColor
        
        dataContainerView.addSubview(titleLabel)
        dataContainerView.addSubview(subtitleLabel)
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
