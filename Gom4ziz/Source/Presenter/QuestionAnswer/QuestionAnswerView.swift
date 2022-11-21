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

    private let divider: UIView = UIView()
    private let artwork: Artwork
    private let questionLabel: UILabel = UILabel()
    private let disposeBag: DisposeBag = .init()
    let answerInputTextView: PlaceholderTextView = .init(placeholder: "내용을 입력하세요.")

    init(artwork: Artwork) {
        self.artwork = artwork
        super.init(frame: .zero)
        self.backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

}

extension QuestionAnswerView {

    func addSubviews() {
        addSubview(divider)
        addSubview(questionLabel)
        addSubview(answerInputTextView)
    }

    func setUpConstraints() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            questionLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            questionLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -16),
            questionLabel.heightAnchor.constraint(equalToConstant: 160)
        ])
        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.leftAnchor.constraint(equalTo: questionLabel.leftAnchor),
            divider.rightAnchor.constraint(equalTo: questionLabel.rightAnchor),
            divider.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            divider.heightAnchor.constraint(equalToConstant: 2),
        ])
        answerInputTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerInputTextView.leftAnchor.constraint(equalTo: questionLabel.leftAnchor),
            answerInputTextView.rightAnchor.constraint(equalTo: questionLabel.rightAnchor),
            answerInputTextView.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 20),
            answerInputTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20)
        ])
    }

    func setUpUI() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(sender:))))
        setUpQuestionLabel()
        setUpDivider()
    }

}

private extension QuestionAnswerView {

    func setUpQuestionLabel() {
        questionLabel.textColor = .white
        questionLabel.font = .systemFont(ofSize: 16, weight: .bold)
        questionLabel.backgroundColor = .blackFont
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.26
        paragraphStyle.alignment = .center
        questionLabel.attributedText = NSMutableAttributedString(string: "# \(artwork.id)\n\(artwork.question)", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
    }

    func setUpDivider() {
        divider.backgroundColor = .black
    }

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
