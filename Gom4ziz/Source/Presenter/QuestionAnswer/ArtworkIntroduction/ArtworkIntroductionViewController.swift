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

    init(
        _ viewModel: QuestionAnswerViewModel
    ) {
        self.viewModel = viewModel
        self.artworkIntroductionView = ArtworkIntroductionView(viewModel.artwork, viewModel.artworkDescription!)
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
            .asDriver()
            .drive(onNext: { [unowned self] in
                switch $0 {
                case .notRequested: break
                case .isLoading:
                    artworkIntroductionView.hideKeyboard()
                    showLottieLoadingView()
                case .loaded:
                    hideLottieLoadingView()
                    break
                    // TODO: 에러 처리 해야함
                case .failed(let error):
                    hideLottieLoadingView()
                    break
                }
            })
            .disposed(by: disposeBag)

        viewModel
            .canUpload
            .asDriver()
            .drive(completeButton.rx.isEnabled)
            .disposed(by: disposeBag)

        artworkIntroductionView
            .review
            .bind(to: viewModel.review)
            .disposed(by: disposeBag)
    }

}

// MARK: - 네비게이션 바 설정 부분
private extension ArtworkIntroductionViewController {

    func setUpNavigationBar() {
        navigationItem.rightBarButtonItem = completeButton
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .gray4
        navigationController?.navigationBar.isTranslucent = false
        completeButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: { [unowned self] in
                self.viewModel.addArtworkReview()
            })
            .disposed(by: disposeBag)
    }
}

#if DEBUG
import SwiftUI
struct ArtworkIntroductionViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: ArtworkIntroductionViewController(QuestionAnswerViewModel()))
        .toPreview()
    }
}
#endif
