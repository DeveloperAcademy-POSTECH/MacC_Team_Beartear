//
//  OnBoardingSecondView.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/25.
//

import UIKit

final class OnBoardingSecondView: BaseAutoLayoutUIView {

    private let onBoardingLabel: UILabel = UILabel()
    let guideVideoView: VideoView
    
    init(urlString: String) {
        guideVideoView = VideoView(url: urlString)
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnBoardingSecondView {
    
    func addSubviews() {
        addSubviews(onBoardingLabel,
                    guideVideoView)
    }
    
    func setUpConstraints() {
        onBoardingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onBoardingLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            onBoardingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        guideVideoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            guideVideoView.topAnchor.constraint(equalTo: onBoardingLabel.bottomAnchor, constant: 16),
            guideVideoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            guideVideoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            guideVideoView.bottomAnchor.constraint(equalTo: bottomAnchor),
            guideVideoView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setUpUI() {
        backgroundColor = .white
        setUpLabel()
    }

}

private extension OnBoardingSecondView {
    
    func setUpLabel() {
        onBoardingLabel.numberOfLines = 2
        onBoardingLabel.attributedText = NSAttributedString("인상깊은 문장에 하이라이팅을 하고\n 내 생각을 정리할 수 있어요")
        onBoardingLabel.textStyle(.Display3, alignment: .center, UIColor.gray4)
    }
}

