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
    private var topDivider: CALayer?
    private var startY: CGFloat?
    private var bottomY: CGFloat!
    private let contentInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: -16)
    private var isInitiated: Bool = false

    init(
        artwork: Artwork,
        descrption: ArtworkDescription
    ) {
        self.artwork = artwork
        self.artworkDescription = descrption
        self.artworkDescriptionTextView = HighlightedTextView(text: artworkDescription.content)
        super.init(frame: .zero)
        setUpPanGestureRecognizer()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // 첫 사이즈가 정해질 때, 각종 위치설정들을 정의함
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isInitiated {
            guard let superview else { return }
            isInitiated = true
            frame = CGRect(x: superview.bounds.minX, y: superview.bounds.height - 160, width: superview.bounds.width, height: superview.bounds.height)
            bottomY = superview.bounds.height - 160
            hideModal()
        }
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
            modalIndicator.widthAnchor.constraint(equalTo: widthAnchor),
            modalIndicator.heightAnchor.constraint(equalToConstant: 40),
            modalIndicator.topAnchor.constraint(equalTo: topAnchor)
        ])
    }

    func setUpScrollViewConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: modalIndicator.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }

    func setUpArtworkNameLabelConstraints() {
        artworkNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            artworkNameLabel.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
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

    func addTopDivider() {
        topDivider = CALayer()
        topDivider!.backgroundColor = UIColor.gray2.cgColor
        topDivider!.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1)
        layer.addSublayer(topDivider!)
    }

    func removeTopDivider() {
        topDivider?.removeFromSuperlayer()
        topDivider = nil
    }

    func setUpSelf() {
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowRadius = 1
        layer.shadowOffset = CGSize(width: 0, height: -1)
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
        let layer: CALayer = CALayer()
        layer.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 22, y: 8, width: 44, height: 4)
        layer.cornerRadius = 2
        layer.masksToBounds = true
        layer.backgroundColor = UIColor.gray2.cgColor
        modalIndicator.layer.addSublayer(layer)
    }

    func setUpArtworkNameLabel() {
        artworkNameLabel.text = artwork.title
        artworkNameLabel.textStyle(.Title, .gray4)
    }

    func setUpScrollView() {
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.indicatorStyle = .black
        scrollView.contentInset = contentInset
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
        let contentInset = contentInset
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = .zero
    }
}

// MARK: - 제스쳐 인식기 설정
private extension ArtworkIntroductionModal {

    func setUpPanGestureRecognizer() {
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onDrag(gestureRecognizer: ))))
    }

    @objc func onDrag(gestureRecognizer: UIPanGestureRecognizer) {
        guard let superView = gestureRecognizer.view else { return }

        // 먼저 드래그 제스처가 시작될 때 시작 y 포지션을 정해준다.
        if startY == nil {
            startY = frame.minY
        }

        let translation: CGPoint = gestureRecognizer.translation(in: superView)
        switch gestureRecognizer.state {
        case .changed:
            onDragChanged(superView, translation)
        case .ended:
            let velocity = gestureRecognizer.velocity(in: superView)
            onDragFinished(velocity, superView, translation)
        default:
            break
        }
    }

    // 애니메이션이 끝난 경우
    func onDragChanged(_ superView: UIView, _ translation: CGPoint) {
        guard let startY else { return }
        // 최종적으로 이동할 위치
        let targetY: CGFloat = startY + translation.y

        // 최종적으로 이동할 위치가, 화면 범위밖이면 이동하지 않는다
        guard targetY <= bottomY && targetY >= 0 else { return }
        UIView.animate(withDuration: 0.2, delay: 0.02, options: .curveEaseInOut) { [self] in
            frame = CGRect(x: 0, y: startY + translation.y, width: frame.width, height: frame.height)
        }
    }

    func onDragFinished(_ velocity: CGPoint, _ superView: UIView, _ tranlsation: CGPoint) {

        // 드래그 제스처가 종료되면, 시작 포지션을 초기화해준다.
        defer {
            startY = nil
        }
        // 만약 아래로 보내는 힘이 100 이상이면 모달을 숨겨준다!
        guard velocity.y < 100 else {
            hideModal()
            return
        }

        // 만약 위로 보내는 힘이 100 이상이면 모달을 보여준다!
        guard velocity.y > -100 else {
            showModal()
            return
        }

        guard let _startY = startY else { return }
        // 타겟의 최종 위치
        let targetY: CGFloat = _startY + tranlsation.y

        // 만약 최종 위치가 100보다 아래있으면, 모달을 보여준다.
        if targetY < 100 {
            showModal()
        } else {
            hideModal()
        }
    }

    func hideModal() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [self] in
            frame = CGRect(x: frame.minX, y: bottomY, width: frame.width, height: frame.height)
            layer.cornerRadius = 16
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            scrollView.isUserInteractionEnabled = false
            removeTopDivider()
        }
        _ = myReviewTextView.resignFirstResponder()
    }

    func showModal() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) { [self] in
            frame = CGRect(x: frame.minX, y: 0, width: frame.width, height: frame.height)
            layer.cornerRadius = 0
            scrollView.isUserInteractionEnabled = true
            addTopDivider()
        }
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
