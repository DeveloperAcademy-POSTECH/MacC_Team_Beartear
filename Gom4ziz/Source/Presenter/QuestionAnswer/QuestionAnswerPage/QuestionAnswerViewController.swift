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
    private let answerViewModel: QuestionAnswerViewModel
    private let questionViewModel: QuestionViewModel
    private let listViewModel: ReviewedArtworkListViewModel
    private let disposeBag: DisposeBag = .init()
    private var isInitiated: Bool = false

    init(
        artwork: Artwork,
        userId: String,
        questionViewModel: QuestionViewModel,
        listViewModel: ReviewedArtworkListViewModel
    ) {
        self.questionViewModel = questionViewModel
        self.listViewModel = listViewModel
        self.questionAnswerView = QuestionAnswerView(artwork: artwork)
        self.answerViewModel = QuestionAnswerViewModel(userId: userId, of: artwork)
        self.nextButton = UIBarButtonItem(title: "다음")
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpObservers()
    }

    override func loadView() {
        self.view = questionAnswerView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isInitiated {
            isInitiated = true
            answerViewModel.fetchArtworkDescription()
        }
    }

}

// MARK: - Private API
private extension QuestionAnswerViewController {

    func setUpObservers() {

        // 작품 설명 로딩 이벤트 관찰
        answerViewModel.artworkDescriptionRelay
            .asDriver()
            .drive(onNext: { [unowned self] event in
                switch event {
                case .failed:
                    self.showErrorView(.loadFailed(type: .artwork), true) {
                        self.answerViewModel.fetchArtworkDescription()
                    }
                default: break
                }
            })
            .disposed(by: disposeBag)

        let answer = questionAnswerView
            .answerInputTextView
            .rx
            .text
            .orEmpty
            .asDriver()

        // 유저 답변 입력, 그리고 상세 정보 로딩 완료 여부 검사
        Driver
            .combineLatest(answer, answerViewModel.artworkDescriptionRelay.asDriver())
            .map { answer, artworkDescription in
                !answer.isEmpty && artworkDescription.value != nil
            }
            .drive(nextButton.rx.isEnabled)
            .disposed(by: disposeBag)

        answer
            .drive(answerViewModel.myAnswer)
            .disposed(by: disposeBag)
    }

}

// MARK: - 화면 이동
private extension QuestionAnswerViewController {

    func showArtworkIntroductionUI() {
        questionAnswerView.answerInputTextView.resignFirstResponder()
        let artworkIntroductionViewController = ArtworkIntroductionViewController(
            answerViewModel,
            questionViewModel,
            listViewModel
        )
        navigationController?.pushViewController(artworkIntroductionViewController, animated: true)
    }

}

// MARK: - Navigation Bar 설정 부분
private extension QuestionAnswerViewController {

    func setUpNavigationBar() {
        navigationItem.rightBarButtonItem = nextButton
        navigationController?.navigationBar.tintColor = .blackFont
        setUpNextButton()
    }

    // 다음 버튼을 누르면, 작품 소개 UI로 넘어간다!
    func setUpNextButton() {
        nextButton.tintColor = .black
        nextButton
            .rx
            .tap
            .bind(onNext: { [unowned self] _ in
                self.showArtworkIntroductionUI()
            })
            .disposed(by: disposeBag)
    }
}

#if DEBUG
import SwiftUI
struct QuestionAnswerViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(
            rootViewController: QuestionAnswerViewController(
                artwork: Artwork.mockData,
                userId: User.mockData.id,
                questionViewModel: QuestionViewModel(user: .mockData),
                listViewModel: .init(user: .mockData)
            )
        )
            .toPreview() 
    }
}
#endif
