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
        // TODO: 나중에 직접 observe 해야함!
        self.artworkIntroductionView = ArtworkIntroductionView(viewModel.artwork, viewModel.artworkDescription.value.value!)
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
        self.view = artworkIntroductionView
    }

}

// MARK: - 옵저버 설정
private extension ArtworkIntroductionViewController {

    func setUpObservers() {
        viewModel.artworkDescription
            .asDriver()
            .drive(onNext: { _ in
            })
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
        completeButton.action = #selector(onCompleteButtonTapped(sender:))
    }

    // TODO: ArtworkReview DB에 업로드하고 홈화면으로 이동해야함!
    @objc func onCompleteButtonTapped(sender: UIBarButtonItem) {

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