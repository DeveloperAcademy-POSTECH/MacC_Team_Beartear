//
//  QuestionAnswerViewController.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/21.
//

import UIKit

import RxCocoa
import RxSwift

final class QuestionAnswerViewController: UIViewController {

    private let questionAnswerView: QuestionAnswerView = QuestionAnswerView(artwork: Artwork.mockData)

    private lazy var nextButton: UIBarButtonItem = {
        let button: UIBarButtonItem = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(onNextButtonClick(sender: )))
        button.tintColor = .black
        return button
    }()

    private let disposeBag: DisposeBag = .init()

    override func viewDidLoad() {
        setUpNavigationBar()
        setUpObservers()
    }

    override func loadView() {
        self.view = questionAnswerView
    }

}

// MARK: - Private API
private extension QuestionAnswerViewController {

    func enableNextButton() {
        nextButton.isEnabled = true
    }

    func disableNextButton() {
        nextButton.isEnabled = false
    }

    func setUpObservers() {
        questionAnswerView.answerInputTextView
            .rx
            .text
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { [unowned self] in
                if $0.isEmpty {
                    disableNextButton()
                } else {
                    enableNextButton()
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Navigation Bar 설정 부분
private extension QuestionAnswerViewController {

    func setUpNavigationBar() {
        navigationItem.title = "작가의 질문"
        navigationItem.rightBarButtonItem = nextButton
    }

    @objc func onNextButtonClick(sender: UIBarButtonItem) {

    }
}

#if DEBUG
import SwiftUI
struct QuestionAnswerViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: QuestionAnswerViewController())
            .toPreview()
    }
}
#endif
