//
//  MyFeedViewController.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/23.
//

import UIKit

import RxCocoa
import RxSwift

final class MyFeedViewController: UIViewController {
    
    // MARK: - Data property
    
    private let user: User
    private let artwork: Artwork
    private let questionAnswer: QuestionAnswer
    
    // MARK: - UI Components
    
    private lazy var myFeedView: MyFeedView = .init(artwork: artwork,
                                                    questionAnswer: questionAnswer)
    private lazy var backButton: UIBarButtonItem = .init(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
    private let editButton: UIBarButtonItem = .init(title: "편집")
    
    private let viewModel: MyFeedViewModel
    private let disposeBag: DisposeBag = .init()
    
    init(user: User,
         artwork: Artwork,
         questionAnswer: QuestionAnswer) {
        self.user = user
        self.artwork = artwork
        self.questionAnswer = questionAnswer
        self.viewModel = .init(fetchArtworkReviewUseCase: RealFetchArtworkReviewUseCase(),
                               fetchArtworkDescriptionUseCase: RealFetchArtworkDescriptionUseCase(),
                               fetchHighlightUseCase: RealFetchHighlightUseCase())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = myFeedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpObservers()
        fetchMyFeedViewModel()
    }
    
}

// MARK: - Private API

private extension MyFeedViewController {
    
    func fetchMyFeedViewModel() {
        viewModel.fetchMyFeed(artworkId: artwork.id,
                              userId: user.id)
    }
    
    func setUpObservers() {
        setMyFeedViewModelObserver()
    }
    
    func setMyFeedViewModelObserver() {
        let myFeedViewModelDriver = viewModel.myFeedViewModelRelay.asDriver()
        myFeedViewModelDriver
            .drive { [weak self] model in
                switch model {
                case .notRequested:
                    break
                case .isLoading:
                    self?.showLottieLoadingView()
                case .loaded:
                    self?.hideLottieLoadingView()
                case .failed:
                    self?.hideLottieLoadingView()
                    self?.setUpErrorView(.tiramisul, false) {
                        self?.viewModel.fetchMyFeed(artworkId: (self?.artwork.id)!,
                                                    userId: (self?.user.id)!)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        myFeedViewModelDriver
            .compactMap({ $0.value?.artworkDescription })
            .drive(myFeedView.highlightTextView.textView.rx.text)
            .disposed(by: disposeBag)
        
        myFeedViewModelDriver
            .compactMap({ $0.value?.highlights })
            .drive(myFeedView.highlightTextView.rx.highlightsBinder)
            .disposed(by: disposeBag)
        
        myFeedViewModelDriver
            .compactMap({ $0.value?.artworkReview })
            .drive(myFeedView.reviewLabel.rx.text)
            .disposed(by: disposeBag)
    }

}

// MARK: - Button Actions

private extension MyFeedViewController {
    
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
    
}

// MARK: - SetUp Navigation Bar

private extension MyFeedViewController {

    func setUpNavigationBar() {
        navigationItem.title = "\(artwork.id)번째 티라미술"
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = editButton
        navigationController?.navigationBar.tintColor = .black
    }
    
}

#if DEBUG
import SwiftUI
struct MyFeedViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: MyFeedViewController(user: .mockData, artwork: .mockData, questionAnswer: .mockData))
            .toPreview()
            .previewDisplayName("데이터 요청 성공")
        
        UINavigationController(rootViewController: MyFeedViewController(user: User(id: "r189u4128947129", lastArtworkId: 1, firstLoginedDate: 1), artwork: .mockData, questionAnswer: .mockData))
            .toPreview()
            .previewDisplayName("데이터 요청 실패")
    }
}
#endif
