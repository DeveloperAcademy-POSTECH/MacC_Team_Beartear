//
//  ArtworkIntroductionModal.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/25.
//

import UIKit

final class ArtworkIntroductionModal: BaseAutoLayoutUIView {

    private let artwork: Artwork
    private let artworkDescription: ArtworkDescription

    private let modalIndicator: UIView = UIView()
    private let scrollView: UIScrollView = UIScrollView()
    private let artworkNameLabel: UILabel = UILabel()
    private let artistLabel: UILabel = UILabel()
    private let artworkIntroductionLabel: SectionTitleView = SectionTitleView(title: "작품 소개")
    private let artworkDescriptionTextView: HighlightedTextView
    private let myReviewLabel: SectionTitleView = SectionTitleView(title: "나의 감상")
    private let myReviewTextView: PlaceholderTextView = PlaceholderTextView(placeholder: "작품을 보고 어떤 생각을 했나요?")

    init(
        artwork: Artwork,
        descrption: ArtworkDescription
    ) {
        self.artwork = artwork
        self.artworkDescription = descrption
        self.artworkDescriptionTextView = HighlightedTextView(text: artworkDescription.content)
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - 프로토콜 구현부
extension ArtworkIntroductionModal {

    func addSubviews() {
        addSubviews(modalIndicator, scrollView)
        scrollView.addSubviews(
            artworkNameLabel,
            artistLabel,
            artworkIntroductionLabel,
            artworkDescriptionTextView,
            myReviewLabel,
            myReviewTextView
        )
    }

    func setUpConstraints() {
        setUpModalIndicatorConstraints()
        setUpScrollViewConstraints()
        setUpArtworkNameLabelConstraints()
        setUpArtistLabelConstraints()
        setUpDescriptionConstraints()
        setUpMyReviewLabelConstraints()
        setUpMyReviewTextViewConstraints()
    }

    func setUpUI() {
        setUpSelf()
        setUpScrollView()
        setUpModalIndicator()
        setUpArtworkNameLabel()
        setUpArtistLabel()
        setUpIntroductionLabel()
        setUpKeyboardObserver()
    }

}

// MARK: - 제약조건 설정
private extension ArtworkIntroductionModal {

    func setUpModalIndicatorConstraints() {
        modalIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            modalIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            modalIndicator.widthAnchor.constraint(equalToConstant: 44),
            modalIndicator.heightAnchor.constraint(equalToConstant: 4),
            modalIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 8)
        ])
    }

    func setUpScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: modalIndicator.bottomAnchor, constant: 8).withPriority(.required),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }

    func setUpArtworkNameLabelConstraints() {
        artworkNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artworkNameLabel.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            artworkNameLabel.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor)
        ])
    }

    func setUpArtistLabelConstraints() {
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artistLabel.topAnchor.constraint(equalTo: artworkNameLabel.bottomAnchor, constant: 4),
            artistLabel.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor)
        ])
    }

    func setUpIntroductionLabel() {
        artworkIntroductionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artworkIntroductionLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 40),
            artworkIntroductionLabel.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor),
            artworkIntroductionLabel.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor)
        ])
    }

    func setUpDescriptionConstraints() {
        artworkDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        artworkDescriptionTextView.setContentHuggingPriority(.required, for: .vertical)
        artworkDescriptionTextView.setContentCompressionResistancePriority(.required, for: .vertical)
        NSLayoutConstraint.activate([
            artworkDescriptionTextView.topAnchor.constraint(equalTo: artworkIntroductionLabel.bottomAnchor, constant: 20),
            artworkDescriptionTextView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor),
            artworkDescriptionTextView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor),
        ])
    }

    func setUpMyReviewLabelConstraints() {
        myReviewLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myReviewLabel.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            myReviewLabel.topAnchor.constraint(equalTo: artworkDescriptionTextView.bottomAnchor, constant: 40),
            myReviewLabel.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor)
        ])
    }

    func setUpMyReviewTextViewConstraints() {
        myReviewTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myReviewTextView.topAnchor.constraint(equalTo: myReviewLabel.bottomAnchor, constant: 20),
            myReviewTextView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor),
            myReviewTextView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor),
            myReviewTextView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            myReviewTextView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
}

// MARK: - UI 설정
private extension ArtworkIntroductionModal {

    func setUpSelf() {
        backgroundColor = .white
        artworkDescriptionTextView.onToggled = { [unowned self] in
            self.artworkDescriptionTextView.setNeedsUpdateConstraints()
            self.myReviewLabel.setNeedsUpdateConstraints()
            self.myReviewTextView.setNeedsUpdateConstraints()
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
                self.layoutIfNeeded()
            }
        }
    }

    func setUpModalIndicator() {
        modalIndicator.backgroundColor = .gray2
        modalIndicator.layer.cornerRadius = 2
        modalIndicator.clipsToBounds = true
    }

    func setUpArtworkNameLabel() {
        artworkNameLabel.text = artwork.title
        artworkNameLabel.textStyle(.Title, .gray4)
    }

    func setUpScrollView() {
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.indicatorStyle = .black
        scrollView.contentInset = .init(top: 0, left: 16, bottom: 16, right: -16)
    }

    func setUpArtistLabel() {
        artistLabel.text = artwork.artist
        artistLabel.textStyle(.Body2, .gray3)
    }

    func setUpKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillAppear(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
                let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                    return
            }

            let contentInset = UIEdgeInsets(
                top: 0.0,
                left: 16,
                bottom: keyboardFrame.size.height + 16,
                right: -16)
            scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.size.height, right: 0)
        scrollView.scrollToBottom()
    }

    @objc func keyboardWillHide() {
        let contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: -16)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = .zero
    }
}

// MARK: - 프리뷰
#if DEBUG
import SwiftUI
struct ArtworkIntroductionModalPreview: PreviewProvider {
    static var previews: some View {
        ArtworkIntroductionModal(artwork: .mockData, descrption: .mockData).toPreview()
    }
}
#endif
