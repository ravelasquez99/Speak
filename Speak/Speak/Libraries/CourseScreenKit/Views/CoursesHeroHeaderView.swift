//
//  CoursesHeroHeaderView.swift
//  Speak
//
//  Created by Richard Velasquez on 3/13/24.
//

import UIKit
import SDWebImage

public final class CoursesHeroHeaderView: UIView {
    private let bannerImageView: UIImageView
    private let circleImageView: UIImageView
    
    public init(
        frame: CGRect,
        bannerImageName: String,
        circleImageURLString: String,
        heroText: String,
        calloutText: String
        
    ) {
        self.bannerImageView = UIImageView(image: UIImage(named: bannerImageName))
        self.circleImageView = UIImageView(frame: .zero)
        super.init(frame: frame)
        self.addSubview(bannerImageView)
        self.addSubview(circleImageView)

        //bannerImageView Setup
        bannerImageView.contentMode = .scaleAspectFill

        //circleImageView Setup
        circleImageView.sd_setImage(with: URL(string: circleImageURLString))
        circleImageView.contentMode = .scaleAspectFill
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        bannerImageView.frame = CGRectMake(
            0,
            0,
            bounds.width,
            floor(bounds.height * 0.6) //magic number with no layout file
        )

        let heightBetweenSafeAreaAndBottomOfImage = bannerImageView.bounds.height - safeAreaInsets.top
        let imageWidthAndHeight = floor(heightBetweenSafeAreaAndBottomOfImage * 0.75) //magic number with no layout file
        
        circleImageView.frame = CGRectMake(
            (bounds.width / 2) - (imageWidthAndHeight / 2),
            bannerImageView.bounds.height - imageWidthAndHeight,
            imageWidthAndHeight,
            imageWidthAndHeight
        )
        circleImageView.layer.cornerRadius = imageWidthAndHeight / 2
        circleImageView.clipsToBounds = true
    }
}
