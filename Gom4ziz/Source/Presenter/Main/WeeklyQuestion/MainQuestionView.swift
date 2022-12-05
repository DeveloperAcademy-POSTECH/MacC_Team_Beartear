//
//  QuestionView.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/29.
//

import UIKit

final class MainQuestionView: BaseAutoLayoutUIView {
    
    private let artwork: Artwork
    private let questionNumberLabel: UILabel = UILabel()
    private let whiteDivider: UIView = UIView()
    private let questionLabel: UILabel = UILabel()
    private let questionImageView: AsyncImageView
    private let maskImageView: UIImageView = UIImageView()
    private let transparentLayer: CALayer = CALayer()
    private let imageMaskNames: [String] = [ImageName.questionImageMask]
    private var imageMask: UIImage? {
        let randomInt = Int.random(in: 0..<imageMaskNames.count)
        let imageName = imageMaskNames[randomInt]
        return UIImage(named: imageName)
    }
    let navigateButton: UIButton = UIButton()
    
    init(artwork: Artwork) {
        self.artwork = artwork
        self.questionImageView = AsyncImageView(
            url: artwork.imageUrl,
            contentMode: .scaleAspectFill)
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpTransparentLayer()
    }
}

extension MainQuestionView {
    
    func addSubviews() {
        addSubviews(questionImageView,
                    maskImageView,
                    questionNumberLabel,
                    whiteDivider,
                    questionLabel,
                    navigateButton)
    }
    
    func setUpConstraints() {
        setUpQuestionImageViewConstraints()
        setUpMaskImageViewConstraints()
        setUpQuestionNumberLabelConstraints()
        setUpWhiteDividerConstraints()
        setUpQuestionLabelConstraints()
        setUpNavigateButtonConstraints()
    }
    
    func setUpUI() {
        setUpSelf()
        setUpQuestionImageView()
        setUpMaskImageView()
        setUpQuestionNumberLabel()
        setUpWhiteDivider()
        setUpQuestionLabel()
        setUpNavigateButton()
    }
}

// MARK: - set UI
private extension MainQuestionView {
    
    func setUpSelf() {
        layer.masksToBounds = true
        backgroundColor = .white
    }
    
    func setUpMaskImageView() {
        maskImageView.image = imageMask
    }
    
    func setUpTransparentLayer() {
        transparentLayer.backgroundColor = UIColor(white: 0, alpha: 0.3).cgColor
        transparentLayer.frame = bounds
        questionImageView.layer.insertSublayer(transparentLayer, at: 0)
    }
    
    func setUpQuestionNumberLabel() {
        questionNumberLabel.textStyle(.Headline1, UIColor.white)
        questionNumberLabel.text = "\(artwork.id)번째 티라미술"
        questionNumberLabel.textColor = .white
    }
    
    func setUpWhiteDivider() {
        whiteDivider.backgroundColor = .white
    }
    
    func setUpQuestionLabel() {
        questionLabel.textStyle(.Display1, lineHeightMultiple: 1.5, alignment: .left, UIColor.white)
        questionLabel.text = artwork.question
        questionNumberLabel.textColor = .white
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byWordWrapping
    }
    
    func setUpNavigateButton() {
        var configuration = UIButton.Configuration.plain()
        let attributes = navigateButton.textStyleAttributes(.Body2, .white)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .light)
        configuration.image = UIImage(systemName: ImageName.rightArrow)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 5
        configuration.baseForegroundColor = .white
        configuration.preferredSymbolConfigurationForImage = imageConfig
        configuration.attributedTitle = AttributedString("질문에 답변하러 가기", attributes: attributes)
        navigateButton.configuration = configuration
    }
    
    func setUpQuestionImageView() {
        questionImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
    }
}

// MARK: - Constraints
private extension MainQuestionView {
    
    func setUpQuestionNumberLabelConstraints() {
        questionNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionNumberLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            questionNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 29)
        ])
    }
    
    func setUpWhiteDividerConstraints() {
        whiteDivider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            whiteDivider.heightAnchor.constraint(equalToConstant: 1),
            whiteDivider.leadingAnchor.constraint(equalTo: questionNumberLabel.leadingAnchor),
            whiteDivider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -29),
            whiteDivider.topAnchor.constraint(equalTo: questionNumberLabel.bottomAnchor, constant: 16)
        ])
    }
    
    func setUpQuestionLabelConstraints() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: whiteDivider.leadingAnchor),
            questionLabel.trailingAnchor.constraint(equalTo: whiteDivider.trailingAnchor),
            questionLabel.topAnchor.constraint(equalTo: whiteDivider.bottomAnchor, constant: 16)
        ])
    }
    
    func setUpNavigateButtonConstraints() {
        navigateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigateButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            navigateButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func setUpQuestionImageViewConstraints() {
        questionImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            questionImageView.topAnchor.constraint(equalTo: topAnchor),
            questionImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            questionImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setUpMaskImageViewConstraints() {
        maskImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maskImageView.topAnchor.constraint(equalTo: topAnchor),
            maskImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            maskImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            maskImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

#if DEBUG
import SwiftUI
struct MainQuestionViewPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            MainQuestionView(artwork: Artwork.mockData)
                .toPreview()
                .frame(width: 390, height: 520)
        }
    }
}
#endif
