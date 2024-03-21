//
//  CoursesHeroHeaderView.swift
//  Speak
//
//  Created by Richard Velasquez on 3/13/24.
//

import Foundation
import UIKit
import SDWebImage

public final class CoursesHeroHeaderView: UIView {
    private let bannerImageView: UIImageView
    private let circleImageView: UIImageView
    private let heroLabel: UILabel
    private let heroLabelFont = UIFont.boldSystemFont(ofSize: 30)
    private let calloutLabel: UILabel

    public init(
        frame: CGRect,
        bannerImageName: String,
        circleImageURLString: String,
        heroText: String,
        calloutText: String
        
    ) {
        self.bannerImageView = UIImageView(image: UIImage(named: bannerImageName))
        self.circleImageView = UIImageView(frame: .zero)
        self.heroLabel = Self.buildGenericLabel()
        self.calloutLabel = Self.buildGenericLabel()

        super.init(frame: frame)
        self.addSubview(bannerImageView)
        self.addSubview(circleImageView)
        self.addSubview(heroLabel)
        self.addSubview(calloutLabel)

        //bannerImageView Setup
        bannerImageView.contentMode = .scaleAspectFill

        //circleImageView Setup
        circleImageView.sd_setImage(with: URL(string: circleImageURLString))
        circleImageView.contentMode = .scaleAspectFill

        //Label Setup
        heroLabel.text = heroText
        calloutLabel.text = calloutText

        heroLabel.font = heroLabelFont
        heroLabel.textColor = SpeakColor.heroText

        calloutLabel.font = .preferredFont(forTextStyle: .callout)
        calloutLabel.textColor = SpeakColor.calloutSubtitleText
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Layout

    public override func layoutSubviews() {
        super.layoutSubviews()
        //Banner image
        bannerImageView.frame = CGRectMake(
            0,
            0,
            bounds.width,
            floor(bounds.height * 0.6) //magic number with no layout file
        )

        //Circle image
        let middleX = (bounds.width / 2)
        let heightBetweenSafeAreaAndBottomOfImage = bannerImageView.bounds.height - safeAreaInsets.top
        let imageWidthAndHeight = heightBetweenSafeAreaAndBottomOfImage //magic number with no layout file
        
        circleImageView.frame = CGRectMake(
            middleX - (imageWidthAndHeight / 2),
            bannerImageView.bounds.height - imageWidthAndHeight,
            imageWidthAndHeight,
            imageWidthAndHeight
        )
        circleImageView.layer.cornerRadius = imageWidthAndHeight / 2
        circleImageView.clipsToBounds = true

        //Text
        let calloutAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .callout)
        ]
        let calloutSize = (calloutLabel.text! as NSString) // force unwrap for simplicity
            .size(withAttributes: calloutAttributes)

        calloutLabel.frame = CGRectMake(
            middleX - (calloutSize.width / 2),
            circleImageView.frame.maxY + 20, //magic number with no layout file
            calloutSize.width,
            calloutSize.height
        )

        let heroLabelAttributes: [NSAttributedString.Key: Any] = [
            .font: heroLabelFont
        ]
        let heroLabelSize = (heroLabel.text! as NSString) // force unwrap for simplicity
            .size(withAttributes: heroLabelAttributes)

        heroLabel.frame = CGRectMake(
            middleX - (heroLabelSize.width / 2),
            calloutLabel.frame.maxY + 4, //magic number with no layout file
            heroLabelSize.width,
            heroLabelSize.height
        )
    }
    
    
    // MARK: - Label Builder / Helpers

    static func buildGenericLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textAlignment = .center
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }
}
