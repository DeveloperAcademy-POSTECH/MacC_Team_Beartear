//
//  QuestionView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/23.
//

import UIKit

final class QuestionView: BaseAutoLayoutUIView, Skeletonable {
    let originalCornerRadius: CGFloat = 12
    var skeletonLayer: CALayer?
    private let artwork: Artwork
    private let questionNumberLabel: UILabel = UILabel()
    private let questionImageView: AsyncImageView
    private let questionLabel: UILabel = UILabel()
    private let whiteDivider: UIView = UIView()
    private let infoContainer: UIView = UIView()

    init(artwork: Artwork) {
        self.artwork = artwork
        questionImageView = AsyncImageView(
            url: artwork.imageUrl,
            contentMode: .scaleAspectFill,
            filterOptions: [
                .contrast(1.2),
                .exposure(0.3)
            ])
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

}

extension QuestionView {

    func addSubviews() {
        addSubview(questionImageView)
        addSubview(infoContainer)
        infoContainer.addSubview(questionNumberLabel)
        infoContainer.addSubview(questionLabel)
        infoContainer.addSubview(whiteDivider)
    }

    func setUpConstraints() {
        setUpInfoContainerConstaints()
        setUpQuestionLabelConstraints()
        setUpWhiteDividerConstraints()
        setUpQuestionNumberLabelConstraints()
        setUpQuestionImageViewConstraints()
    }

    func setUpUI() {
        setUpQuestionImageView()
        setUpQuestionLabel()
        setUpWhiteDivider()
        setUpQuestionNumberLabel()
        setUpSelf()
    }

}

// MARK: - 오토레이아웃 제약조건 설정
private extension QuestionView {

    func setUpInfoContainerConstaints() {
        infoContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoContainer.topAnchor.constraint(equalTo: topAnchor),
            infoContainer.leftAnchor.constraint(equalTo: leftAnchor),
            infoContainer.rightAnchor.constraint(equalTo: rightAnchor),
            infoContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setUpQuestionNumberLabelConstraints() {
        questionNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        questionNumberLabel.setContentHuggingPriority(.required, for: .vertical)
        questionNumberLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        NSLayoutConstraint.activate([
            questionNumberLabel.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor),
            questionNumberLabel.bottomAnchor.constraint(equalTo: whiteDivider.topAnchor, constant: -5),
            questionNumberLabel.topAnchor.constraint(equalTo: infoContainer.topAnchor, constant: 48)
        ])

    }
    func setUpQuestionLabelConstraints() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.setContentHuggingPriority(.required, for: .vertical)
        questionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        NSLayoutConstraint.activate([
            questionLabel.leftAnchor.constraint(equalTo: infoContainer.leftAnchor, constant: 16),
            questionLabel.rightAnchor.constraint(equalTo: infoContainer.rightAnchor, constant: -16),
            questionLabel.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: -48)
        ])
    }
    func setUpQuestionImageViewConstraints() {
        questionImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionImageView.topAnchor.constraint(equalTo: infoContainer.topAnchor),
            questionImageView.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor),
            questionImageView.leftAnchor.constraint(equalTo: infoContainer.leftAnchor),
            questionImageView.rightAnchor.constraint(equalTo: infoContainer.rightAnchor),
        ])
    }
    func setUpWhiteDividerConstraints() {
        whiteDivider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            whiteDivider.bottomAnchor.constraint(equalTo: questionLabel.topAnchor, constant: -9),
            whiteDivider.widthAnchor.constraint(equalToConstant: 40),
            whiteDivider.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor),
            whiteDivider.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
}

// MARK: - UI 설정
private extension QuestionView {

    func setUpSelf() {
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }

    func setUpQuestionNumberLabel() {
        questionNumberLabel.text = "\(artwork.id)번째 작품"
        questionNumberLabel.textColor = .white
        questionNumberLabel.textStyle(.Caption, .white)
    }

    func setUpQuestionLabel() {
        questionLabel.textAlignment = .center
        questionLabel.text = "\(artwork.question)"
        questionLabel.textColor = .white
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.textStyle(.Display3, lineHeightMultiple: 1.26, alignment: .center, .white)
    }

    func setUpQuestionImageView() {
        questionImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }

    func setUpWhiteDivider() {
        whiteDivider.backgroundColor = .white
    }
}
