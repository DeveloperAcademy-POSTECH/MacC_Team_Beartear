//
//  OnBoardingFirstView.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/25.
//

import UIKit

final class OnBoardingFirstView: BaseAutoLayoutUIView {
    
    private let onBoardingLabel = UILabel()
    private let guideImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnBoardingFirstView {
    
    func addSubviews() {
        addSubviews(onBoardingLabel,
                    guideImageView)
    }
    
    func setUpConstraints() {
        onBoardingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onBoardingLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            onBoardingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        guideImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            guideImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            guideImageView.widthAnchor.constraint(equalToConstant: 358),
            guideImageView.heightAnchor.constraint(equalToConstant: 277),
            guideImageView.topAnchor.constraint(equalTo: onBoardingLabel.bottomAnchor, constant: 107)
        ])
    }
    
    func setUpUI() {
        backgroundColor = .white
        setUpLabel()
        setUpGuideImageView()
    }
}

private extension OnBoardingFirstView {
    
    func setUpLabel() {
        onBoardingLabel.numberOfLines = 2
        onBoardingLabel.attributedText = NSAttributedString("질문을 통해서 작품의 메시지에\n 대해 생각하고 감상해보세요")
        onBoardingLabel.textStyle(.Display3, alignment: .center, UIColor.gray4)
    }
    
    func setUpGuideImageView() {
        guideImageView.contentMode = .scaleAspectFill
        guideImageView.image = UIImage(named: ImageName.onBoarding1Image)
    }
}
