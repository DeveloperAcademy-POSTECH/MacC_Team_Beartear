//
//  UpdateReviewViewController.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/12/02.
//

import UIKit

import RxCocoa
import RxSwift

final class UpdateReviewViewController: UIViewController {
    
    private lazy var updateReviewView: UpdateReviewView = .init(question: viewModel.artwork.question, myAnswer: viewModel.myAnswer.value, myReview: viewModel.review.value)

    private lazy var cancelButton: UIBarButtonItem = .init(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
    private lazy var completeButton: UIBarButtonItem = .init(title: "완료")
    
    let viewModel: MyFeedViewModel
    private let disposeBag: DisposeBag = .init()
    
    init(_ viewModel: MyFeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = updateReviewView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setObserver()
    }
    
}

extension UpdateReviewViewController {
    
    func setUpNavigationBar() {
        navigationItem.title = "편집"
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = completeButton
        navigationController?.navigationBar.tintColor = .black
    }
    
}

extension UpdateReviewViewController {
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
}

extension UpdateReviewViewController {
    
    func setObserver() {
        viewModel.updateEvent
            .asDriver(onErrorJustReturn: .notRequested)
            .drive(onNext: { [weak self] in
                switch $0 {
                case .notRequested:
                    break
                case .isLoading:
                    self?.showLottieLoadingView()
                case .loaded:
                    self?.hideLottieLoadingView()
                    self?.dismiss(animated: true)
                case .failed:
                    self?.hideLottieLoadingView()
                    self?.showErrorAlert(title: "감상문을 편집하는데 실패했습니다.",
                                         suggestion: "작성한 감상문이 편집되지 않았습니다. 다시 시도하여 감상문을 편집해주세요.") { [unowned self] in
                        self?.viewModel.updateArtworkReview()
                    }
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.review
            .bind(to: updateReviewView.myReviewInputTextView.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.myAnswer
            .bind(to: updateReviewView.myAnswerInputTextView.rx.text)
            .disposed(by: disposeBag)
        
        completeButton
            .rx
            .tap
            .subscribe(onNext: { [unowned self] in
                self.viewModel.updateArtworkReview()
            })
            .disposed(by: disposeBag)
    }
    
}
