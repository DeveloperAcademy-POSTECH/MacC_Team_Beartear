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
    private var isInitiated: Bool = false

    init(artwork: Artwork, userId: String) {
        self.questionAnswerView = QuestionAnswerView(artwork: artwork)
        self.viewModel = QuestionAnswerViewModel(userId: userId, of: artwork)
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
            viewModel.fetchArtworkDescription()
        }
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

        // 작품 설명 로딩 이벤트 관찰
        viewModel.artworkDescriptionRelay
            .asDriver()
            .drive(onNext: { [weak self] event in
                switch event {
                case .isLoading:
                    self?.questionAnswerView.showSkeletonUI()
                case .loaded:
                    self?.questionAnswerView.hideSkeletonUI()
                    self?.focusOnTextView()
                case .failed(let error):
                    // TODO: 에러 뷰 보여줘야함
                    break
                default: break
                }
            })
            .disposed(by: disposeBag)

        // 유저 답변 입력 관찰
        questionAnswerView.answerInputTextView
            .rx
            .text
            .compactMap { $0 }
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { [unowned self] in
                // 만약 유저가 답변을 입력하고, artworkDescription이 존재한다면 다음 버튼이 활성화된다.
                if !$0.isEmpty && viewModel.artworkDescription != nil {
                    enableNextButton()
                    return
                }
                // 만약 유저가 답변을 입력하지 않았거나, artworkDescription이 불러와지지 않은 경우 다음 버튼이 비활성화된다.
                disableNextButton()
            })
            .disposed(by: disposeBag)

        questionAnswerView
            .answerInputTextView
            .rx
            .text
            .orEmpty
            .bind(to: viewModel.myAnswer)
            .disposed(by: disposeBag)
    }

}

// MARK: - 화면 이동
private extension QuestionAnswerViewController {

    func showArtworkIntroductionUI() {
        questionAnswerView.answerInputTextView.resignFirstResponder()
        let artworkIntroductionViewController = ArtworkIntroductionViewController(viewModel)
        navigationController?.pushViewController(artworkIntroductionViewController, animated: true)
    }

}

// MARK: - Navigation Bar 설정 부분
private extension QuestionAnswerViewController {

    func setUpNavigationBar() {
        navigationItem.rightBarButtonItem = nextButton
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
        UINavigationController(rootViewController: QuestionAnswerViewController(artwork: Artwork.mockData, userId: User.mockData.id))
            .toPreview() 
    }
}
#endif
