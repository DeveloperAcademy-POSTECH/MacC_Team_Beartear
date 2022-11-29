//
//  OnBoardingThirdView.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/25.
//

import UIKit

final class OnBoardingThirdView: BaseAutoLayoutUIView {
    
    private let imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnBoardingThirdView {
    
    func addSubviews() {
        addSubview(imageView)
    }
    
    func setUpConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 180),
            imageView.heightAnchor.constraint(equalToConstant: 248),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setUpUI() {
        backgroundColor = .white
        setUpImageViewUI()
    }
}

extension OnBoardingThirdView {
    
    func setUpImageViewUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: ImageName.onBoarding3Image)
    }
}

