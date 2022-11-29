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
    
    private let myFeedView: MyFeedView = .init(artwork: .mockData, artworkDescription: .mockData, questionAnswer: .mockData, artworkReview: .mockData, highlights: [])
    private let viewModel: MyFeedViewModel = MyFeedViewModel(fetchArtworkReviewUseCase: RealFetchArtworkReviewUseCase(),
                                                             fetchArtworkDescriptionUseCase: RealFetchArtworkDescriptionUseCase(),
                                                             fetchHighlightUseCase: RealFetchHighlightUseCase())
    private let disposebag: DisposeBag = .init()
    
    private var isLoading: Bool {
        didSet {
            if oldValue {
                setUpLoadingView(loadingView)
            } else {
                removeLoadingView(loadingView)
                
                if isError {
                    setUpErrorView(errorView)
                }
            }
        }
    }
    
    private let user: User
    private let artwork: Artwork
    private let questionAnswer: QuestionAnswer
    
    private let myFeedView: MyFeedView
    private lazy var backButton: UIBarButtonItem = .init(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
    private let editButton: UIBarButtonItem
    
    private let loadingView: LoadingView = .init()
    private let errorView: ErrorView = .init(message: .tiramisul, isShowLogo: false)
    // TODO: 로고 생기면 바꿔야함
    private let viewModel: MyFeedViewModel
    private let disposeBag: DisposeBag = .init()
    private var artworkDescriptionError = false
    private var artworkReviewError = false
    private var highlightsError = false
    
    init(user: User,
         artwork: Artwork,
         questionAnswer: QuestionAnswer,
         isLoading: Bool = false) {
        self.user = user
        self.artwork = artwork
        self.questionAnswer = questionAnswer
        self.isLoading = isLoading
        self.myFeedView = .init(artwork: artwork,
                                questionAnswer: questionAnswer)
        self.viewModel = .init(fetchArtworkReviewUseCase: RealFetchArtworkReviewUseCase(),
                                         fetchArtworkDescriptionUseCase: RealFetchArtworkDescriptionUseCase(),
                                         fetchHighlightUseCase: RealFetchHighlightUseCase())
        self.editButton = UIBarButtonItem(title: "편집")
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
        fetchMyFeedViewModelMapper()
        setUpNavigationBar()
        setUpObservers()
    }
    
}

// MARK: - Private API
private extension MyFeedViewController {
    
    func fetchMyFeedViewModelMapper() {
        viewModel.fetchMyFeed(artworkId: artwork.id,
                              userId: user.id)
    }
    
    func setUpObservers() {
        setArtworkDescriptionObserver()
        setHighlightsObserver()
        setArtworkReviewObserver()
        setErrorViewObserver()
    }
    
    func setArtworkDescriptionObserver() {
        viewModel.myFeedViewModelMapper
            .map { mapper in
                switch mapper {
                case .notRequested, .isLoading:
                    self.isLoading = true
                    self.artworkDescriptionError = false
                    return mapper.description
                case .loaded(let data):
                    self.isLoading = false
                    return data.artworkDescription
                case .failed:
                    self.isLoading = false
                    self.artworkDescriptionError = true
                    return mapper.description
                }
            }
            .subscribe { [weak self] in
                self?.myFeedView.highlightTextView.textView.text = $0
            }
            .disposed(by: disposeBag)
    }
    
    func setHighlightsObserver() {
        viewModel.myFeedViewModelMapper
            .map { mapper in
                switch mapper {
                case .notRequested, .isLoading:
                    self.isLoading = true
                    self.highlightsError = false
                    return []
                case .loaded(let data):
                    self.isLoading = false
                    return data.highlights
                case .failed:
                    self.isLoading = false
                    self.highlightsError = true
                    return []
                }
            }
            .subscribe { [weak self] in
               self?.myFeedView.highlightTextView.highlights = $0
            }
            .disposed(by: disposeBag)
    }
    
    func setArtworkReviewObserver() {
        viewModel.myFeedViewModelMapper
            .map { mapper in
                switch mapper {
                case .notRequested, .isLoading:
                    self.isLoading = true
                    self.artworkReviewError = false
                    return mapper.description
                case .loaded(let data):
                    self.isLoading = false
                    return data.artworkReview
                case .failed:
                    self.isLoading = false
                    self.artworkReviewError = true
                    return mapper.description
                }
            }
            .subscribe { [weak self] in
                self?.myFeedView.reviewLabel.text = $0
            }
            .disposed(by: disposeBag)
    }
    
    func setErrorViewObserver() {
        errorView.retryButton
            .rx
            .tap
            .subscribe { _ in
                self.removeErrorView(self.errorView)
                self.viewModel.fetchMyFeed(artworkId: self.artwork.id,
                                        userId: self.user.id)
            }
            .disposed(by: disposeBag)
    }

}

private extension MyFeedViewController {
    
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
    
}

// MARK: - Navigation Bar 설정 부분
private extension MyFeedViewController {

    func setUpNavigationBar() {
        navigationItem.title = "\(artwork.id)번째 티라미술"
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = editButton
        setUpBackButton()
        setUpEditButton()
    }
    
    func setUpBackButton() {
        backButton.tintColor = .black
    }

    func setUpEditButton() {
        editButton.tintColor = .black
    }
    
}

#if DEBUG
import SwiftUI
struct MyFeedViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: MyFeedViewController(user: .mockData, artwork: .mockData, questionAnswer: .mockData))
            .toPreview()
            .padding()
            .previewDisplayName("노 로딩")
        
        UINavigationController(rootViewController: MyFeedViewController(user: .mockData, artwork: .mockData, questionAnswer: .mockData, isLoading: true))
            .toPreview()
            .padding()
            .previewDisplayName("로딩중")
    }
}
#endif
