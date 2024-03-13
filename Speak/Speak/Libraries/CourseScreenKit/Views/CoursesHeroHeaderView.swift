//
//  CoursesHeroHeaderView.swift
//  Speak
//
//  Created by Richard Velasquez on 3/13/24.
//

import UIKit

public final class CoursesHeroHeaderView: UIView {
    private let bannerImageView: UIImageView
    
    public init(
        frame: CGRect,
        bannerImageName: String,
        circleImageURLString: String,
        heroText: String,
        calloutText: String
        
    ) {
        self.bannerImageView = UIImageView(image: UIImage(named: bannerImageName))
        super.init(frame: frame)
        self.addSubview(bannerImageView)

        //bannerImageView Setup
        bannerImageView.contentMode = .scaleAspectFill
        bannerImageView.layer.borderWidth = 1.0
        bannerImageView.layer.borderColor = UIColor.black.cgColor
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
    }
}
