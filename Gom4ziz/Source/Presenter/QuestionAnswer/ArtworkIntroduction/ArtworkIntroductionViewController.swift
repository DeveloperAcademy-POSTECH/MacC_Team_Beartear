//
//  ArtworkIntroductionViewController.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/27.
//

import UIKit

import RxSwift

final class ArtworkIntroductionViewController: UIViewController {

    private let artworkIntroductionView: ArtworkIntroductionView
    private var completeButton: UIBarButtonItem = UIBarButtonItem(title: "완료")
    private let viewModel: QuestionAnswerViewModel
    private let disposeBag: DisposeBag = .init()
    private let questionViewModel: QuestionViewModel
    private let listViewModel: ReviewedArtworkListViewModel

    init(
        _ viewModel: QuestionAnswerViewModel,
        _ questionViewModel: QuestionViewModel,
        _ listViewModel: ReviewedArtworkListViewModel
    ) {
        self.questionViewModel = questionViewModel
        self.listViewModel = listViewModel
        self.viewModel = viewModel
        self.artworkIntroductionView = ArtworkIntroductionView(
            artwork: viewModel.artwork,
            artworkDescription: viewModel.artworkDescriptionRelay.value.value!,
            review: viewModel.review.value,
            highlights: viewModel.highlights.value
        )
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpObserver()
        setUpNavigationBar()
    }

    override func loadView() {
        self.view = artworkIntroductionView
    }

}

// MARK: - 뷰모델 릴레이 옵저버 설정
private extension ArtworkIntroductionViewController {

    func setUpObserver() {
        viewModel.addEvent
            .asDriver(onErrorJustReturn: .notRequested)
            .drive(onNext: { [unowned self] in
                switch $0 {
                case .notRequested: break
                case .isLoading:
                    artworkIntroductionView.hideKeyboard()
                    showLottieLoadingView()
                case .loaded:
                    hideLottieLoadingView()
                    showToastMessage(text: "감상문을 성공적으로 저장했습니다.")
                    questionViewModel.addReviewInput.accept(())
                    listViewModel.addReviewInput.accept(())
                    navigationController?.popToRootViewController(animated: true)
                case .failed:
                    hideLottieLoadingView()
                    showErrorAlert(title: "감상문을 저장하는데 실패했습니다.", suggestion: "작성한 감상문이 저장되지 않았습니다. 다시 시도하여 감상문을 저장해주세요.") { [unowned self] in
                        self.viewModel.addArtworkReview()
                    }
                }
            })
            .disposed(by: disposeBag)

        artworkIntroductionView
            .review
            .bind(to: viewModel.review)
            .disposed(by: disposeBag)
        
        artworkIntroductionView
            .highlights
            .bind(to: viewModel.highlights)
            .disposed(by: disposeBag) 

    }

}

// MARK: - 네비게이션 바 설정 부분
private extension ArtworkIntroductionViewController {

    func setUpNavigationBar() {
        navigationItem.rightBarButtonItem = completeButton
        navigationController?.navigationBar.tintColor = .gray4
        completeButton
            .rx
            .tap
            .subscribe(onNext: { [unowned self] in
                self.viewModel.addArtworkReview()
            })
            .disposed(by: disposeBag)
    }
}

#if DEBUG
import SwiftUI
struct ArtworkIntroductionViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: ArtworkIntroductionViewController(
            QuestionAnswerViewModel(),
            QuestionViewModel(user: .mockData),
            ReviewedArtworkListViewModel(user: User.mockData)
        ))
        .toPreview()
    }
}
#endif
