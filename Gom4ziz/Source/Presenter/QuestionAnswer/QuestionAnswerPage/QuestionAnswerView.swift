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
    let answerInputTextView: PlaceholderTextView = .init(placeholder: "내용을 입력하세요")

    init(artwork: Artwork) {
        self.artwork = artwork
        self.questionView = QuestionView(artwork: artwork)
        super.init(frame: .zero)
        self.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

}

extension QuestionAnswerView {

    func addSubviews() {
        addSubview(questionView)
        addSubview(myThinkLabel)
        addSubview(answerInputTextView)
    }

    func setUpConstraints() {
        questionView.translatesAutoresizingMaskIntoConstraints = false
        questionView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        NSLayoutConstraint.activate([
            questionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            questionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            questionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16)
        ])

        myThinkLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myThinkLabel.leftAnchor.constraint(equalTo: questionView.leftAnchor),
            myThinkLabel.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 20),
            myThinkLabel.rightAnchor.constraint(equalTo: questionView.rightAnchor)
        ])

        answerInputTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerInputTextView.leftAnchor.constraint(equalTo: questionView.leftAnchor),
            answerInputTextView.rightAnchor.constraint(equalTo: questionView.rightAnchor),
            answerInputTextView.topAnchor.constraint(equalTo: myThinkLabel.bottomAnchor, constant: 20),
            answerInputTextView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor, constant: -16)
        ])
    }

    func setUpUI() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(sender:))))
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
