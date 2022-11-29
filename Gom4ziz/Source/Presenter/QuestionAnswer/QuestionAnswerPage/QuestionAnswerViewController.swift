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

    private let questionAnswerView: QuestionAnswerView
    private let nextButton: UIBarButtonItem
    private let viewModel: QuestionAnswerViewModel
    private let disposeBag: DisposeBag = .init()

    init(artwork: Artwork) {
        self.questionAnswerView = QuestionAnswerView(artwork: artwork)
        self.viewModel = QuestionAnswerViewModel(of: artwork)
        self.nextButton = UIBarButtonItem(title: "다음")
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        setUpNavigationBar()
        setUpObservers()
    }

    override func loadView() {
        self.view = questionAnswerView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        focusOnTextView()
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

    func focusOnTextView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            _ = questionAnswerView
                .answerInputTextView
                .becomeFirstResponder()
        }
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
        let numberOfArtwork: Int = viewModel.artwork.id
        navigationItem.title = "\(numberOfArtwork)번째 티라미수"
        navigationItem.rightBarButtonItem = nextButton
        setUpNextButton()
    }

    func setUpNextButton() {
        nextButton.tintColor = .black
        nextButton
            .rx
            .tap
            .bind { _ in
            }
            .disposed(by: disposeBag)
    }
}

#if DEBUG
import SwiftUI
struct QuestionAnswerViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: QuestionAnswerViewController(artwork: Artwork.mockData))
            .toPreview()
    }
}
#endif
