//
//  QuestionAnswerView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/21.
//

import UIKit

import RxCocoa
import RxSwift

final class QuestionAnswerView: BaseAutoLayoutUIView {

    private let artwork: Artwork
    private let questionView: QuestionView
    private let myThinkLabel: SectionTitleView = SectionTitleView(title: "나의 생각")
    private let disposeBag: DisposeBag = .init()
    private let scrollView: UIScrollView = UIScrollView()
    private let baseInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: -16)
    let answerInputTextView: PlaceholderTextView = .init(placeholder: "내용을 입력하세요")

    init(artwork: Artwork) {
        self.artwork = artwork
        self.questionView = QuestionView(artwork: artwork)
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.setUpKeyboardObserver()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

}

// MARK: - 프로토콜 구현부
extension QuestionAnswerView {

    func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubviews(
            questionView,
            myThinkLabel,
            answerInputTextView
        )
    }

    func setUpConstraints() {

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        scrollView.contentInset = baseInsets

        questionView.translatesAutoresizingMaskIntoConstraints = false
        questionView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        NSLayoutConstraint.activate([
            questionView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 12),
            questionView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor),
            questionView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor)
        ])

        myThinkLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myThinkLabel.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor),
            myThinkLabel.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 20),
            myThinkLabel.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor)
        ])

        answerInputTextView.translatesAutoresizingMaskIntoConstraints = false
        answerInputTextView.isScrollEnabled = false
        NSLayoutConstraint.activate([
            answerInputTextView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor),
            answerInputTextView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor),
            answerInputTextView.topAnchor.constraint(equalTo: myThinkLabel.bottomAnchor, constant: 20),
            answerInputTextView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            answerInputTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
    }

    func setUpUI() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(sender:))))
    }

}

// MARK: - 키보드가 올라올 시 스크롤뷰의 콘텐츠 오프셋을 조정하는 부분입니다.
private extension QuestionAnswerView {

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
        let contentInset = baseInsets
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = .zero
    }

}

private extension QuestionAnswerView {

    /// 유저가 화면을 탭할 경우, 키보드를 숨깁니다.
    /// - Parameter sender: 제스쳐 식별기
    @objc func handleTapGesture(sender: UITapGestureRecognizer) {
        if answerInputTextView.canResignFirstResponder {
            _ = answerInputTextView.resignFirstResponder()
        }
    }

}

#if DEBUG
import SwiftUI
struct QuestionAnswerPreview: PreviewProvider {
    static var previews: some View {
        QuestionAnswerView(artwork: .mockData).toPreview()
    }
}
#endif
