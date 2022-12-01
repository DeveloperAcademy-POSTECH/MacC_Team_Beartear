//
//  ErrorAlert.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/12/01.
//

import UIKit

final class ErrorAlert: BaseAutoLayoutUIView {

    private let onRetryButtonTapped: () -> Void
    private let title: String
    private let recoverySuggestion: String
    private let image: UIImageView = UIImageView(image: UIImage(named: ImageName.errorImage))
    private let titleLabel: UILabel = UILabel()
    private let suggestionLabel: UILabel = UILabel()
    private let cancelButton: UIButton = UIButton()
    private let retryButton: UIButton = UIButton()
    private let container: UIView = UIView()

    init(
        title: String,
        recoverySuggestion: String,
        onRetryButtonTapped: @escaping () -> Void
    ) {
        self.title = title
        self.recoverySuggestion = recoverySuggestion
        self.onRetryButtonTapped = onRetryButtonTapped
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - 내부구현
private extension ErrorAlert {

    @objc func closeAlert() {
        self.removeFromSuperview()
    }

    @objc func retry() {
        closeAlert()
        self.onRetryButtonTapped()
    }
}

// MARK: - 프로토콜 구현
extension ErrorAlert {

    func addSubviews() {
        addSubview(container)
        container.addSubviews(
            image,
            titleLabel,
            suggestionLabel,
            cancelButton,
            retryButton
        )
    }

    func setUpConstraints() {
        setUpContainerConstraints()
        setUpImageConstraints()
        setUpTitleConstraints()
        setUpSuggestionConstraints()
        setUpCancelButtonConstraints()
        setUpRetryButtonConstraints()
    }

    func setUpUI() {
        setUpSelf()
        setUpTitleLabel()
        setUpSuggestionLabel()
        setUpCancelButton()
        setUpRetryButton()
    }

}

// MARK: - 제약조건 설정
private extension ErrorAlert {

    func setUpContainerConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.leftAnchor.constraint(equalTo: leftAnchor, constant: 26),
            container.rightAnchor.constraint(equalTo: rightAnchor, constant: -26)
        ])
    }

    func setUpImageConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.setContentHuggingPriority(.required, for: .vertical)
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            image.topAnchor.constraint(equalTo: container.topAnchor, constant: 40)
        ])
    }

    func setUpTitleConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 50),
            titleLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 47),
            titleLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -47),
        ])
    }

    func setUpSuggestionConstraints() {
        suggestionLabel.translatesAutoresizingMaskIntoConstraints = false
        suggestionLabel.setContentHuggingPriority(.required, for: .vertical)
        NSLayoutConstraint.activate([
            suggestionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            suggestionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            suggestionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor)
        ])
    }

    func setUpCancelButtonConstraints() {
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setContentHuggingPriority(.required, for: .vertical)
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: suggestionLabel.bottomAnchor, constant: 42),
            cancelButton.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -40),
        ])

    }

    func setUpRetryButtonConstraints() {
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        retryButton.setContentHuggingPriority(.required, for: .vertical)
        NSLayoutConstraint.activate([
            retryButton.topAnchor.constraint(equalTo: cancelButton.topAnchor),
            retryButton.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            retryButton.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor)
        ])
    }

}

// MARK: - UI 설정
private extension ErrorAlert {

    func setUpSelf() {
        backgroundColor = .black.withAlphaComponent(0.5)
        container.backgroundColor = .white
        container.layer.cornerRadius = 16
        container.layer.masksToBounds = true
    }

    func setUpTitleLabel() {
        titleLabel.text = title
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.textStyle(.Headline1, lineHeightMultiple: 1.12, alignment: .center, .black)
        titleLabel.numberOfLines = 0
    }

    func setUpSuggestionLabel() {
        suggestionLabel.text = recoverySuggestion
        suggestionLabel.textStyle(.Caption, lineHeightMultiple: 1.25, alignment: .center, .gray3)
        suggestionLabel.numberOfLines = 0
        suggestionLabel.lineBreakMode = .byWordWrapping
    }

    func setUpCancelButton() {
        let attributes: AttributeContainer = cancelButton.textStyleAttributes(.Headline2, .gray4)
        var configuration: UIButton.Configuration = .borderless()
        configuration.attributedTitle = AttributedString("취소", attributes: attributes)
        configuration.contentInsets = .init(top: 8, leading: 27, bottom: 4, trailing: 16)
        cancelButton.configuration = configuration
        cancelButton.addTarget(self, action: #selector(closeAlert), for: .touchUpInside)
    }

    func setUpRetryButton() {
        let attributes: AttributeContainer = retryButton.textStyleAttributes(.Headline2, .orange)
        var configuration: UIButton.Configuration = .borderless()
        configuration.attributedTitle = AttributedString("다시 시도", attributes: attributes)
        configuration.contentInsets = .init(top: 8, leading: 16, bottom: 4, trailing: 27)
        retryButton.configuration = configuration
        retryButton.addTarget(self, action: #selector(retry), for: .touchUpInside)
    }

}

// MARK: - 프리뷰
#if DEBUG
import SwiftUI
struct ErrorAlertPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            ErrorAlert(
                title: "감상문을 저장하는데 실패했습니다.",
                recoverySuggestion: "작성한 감상문이 저장되지 않았습니다. 다시 시도하여 감상문을 저장해주세요") {

                }.toPreview()
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
