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
            dayLabelBottom.text = "Day \(dayNumber ?? 0)"
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
            //TBD on the imageview
        }
    }
    
    
    // MARK: - Container Views

    private let dayContainerView = UIView()
    private let dayContainerViewHeight: CGFloat = 50


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
        dayContainerView.addSubview(dayLabelTop)
        dayContainerView.addSubview(dayLabelBottom)

        contentView.addSubview(imageAndIconView)
        imageAndIconView.addSubview(dayImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)

        //Label Setup
    }


    // MARK: - Layout

    override public func layoutSubviews() {
        dayContainerView.frame = CGRectMake(
            12,
            contentView.bounds.midY - (dayContainerViewHeight / 2),
            dayContainerViewHeight,
            dayContainerViewHeight
        )
        
        dayContainerView.backgroundColor = UIColor.yellow

//        dayLabelTop
//        dayLabelBottom.frame = CGRectMake(
//            12,
//            contentView.bounds.midY - 40,
//            80,
//            20
//        )

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
