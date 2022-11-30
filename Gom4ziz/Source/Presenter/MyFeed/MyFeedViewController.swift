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
    
    private lazy var myFeedView: MyFeedView = .init(artwork: artwork, questionAnswer: questionAnswer)
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
        setMyFeedViewModelObserver()
        setErrorViewObserver()
    }
    
    func setMyFeedViewModelObserver() {
        viewModel.myFeedViewModelRelay
            .asDriver()
            .drive { [weak self] model in
                switch model {
                case .notRequested, .isLoading:
                    self?.setUpLoadingView()
                case .loaded(let data):
                    self?.removeLoadingView()
                    self?.myFeedView.myFeedViewModelDTO = data
                case .failed:
                    self?.removeLoadingView()
                    self?.setUpErrorView(.tiramisul, false)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func setErrorViewObserver() {
        getErrorView()?.retryButton
            .rx
            .tap
            .subscribe({ [weak self] _ in
                self?.viewModel.fetchMyFeed(artworkId: (self?.artwork.id)!,
                                            userId: (self?.user.id)!)
            })
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
