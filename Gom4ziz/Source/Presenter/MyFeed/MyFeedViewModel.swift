//
//  MyFeedViewModel.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/21.
//

import Foundation

import RxRelay
import RxSwift

struct MyFeedViewModelMapper {
    let artworkDescription: String
    let highlights: [Highlight]
    let artworkReview: String
    
    init(artworkDescription: ArtworkDescription,
         highlights: [Highlight],
         artworkReview: ArtworkReview) {
        self.artworkDescription = artworkDescription.content
        self.highlights = highlights
        self.artworkReview = artworkReview.review
    }
}

final class MyFeedViewModel {
    
    private let fetchArtworkReviewUseCase: FetchArtworkReviewUseCase
    private let fetchArtworkDescriptionUseCase: FetchArtworkDescriptionUseCase
    private let fetchHighlightUseCase: FetchHighlightUseCase
    let myFeedViewModelMapper: BehaviorRelay<Loadable<MyFeedViewModelMapper>> = .init(value: .notRequested)
    
    private let disposeBag: DisposeBag = .init()
    
    init(fetchArtworkReviewUseCase: FetchArtworkReviewUseCase,
         fetchArtworkDescriptionUseCase: FetchArtworkDescriptionUseCase,
         fetchHighlightUseCase: FetchHighlightUseCase) {
        self.fetchArtworkReviewUseCase = fetchArtworkReviewUseCase
        self.fetchArtworkDescriptionUseCase = fetchArtworkDescriptionUseCase
        self.fetchHighlightUseCase = fetchHighlightUseCase
    }
    
    func fetchMyFeed(artworkId: Int, userId: String) {
        myFeedViewModelMapper.accept(.isLoading(last: nil))
        Observable.zip(fetchArtworkDescription(of: artworkId),
                       fetchHighlight(of: artworkId, userId),
                       fetchArtworkReview(of: artworkId, userId))
        .map { (description: ArtworkDescription, highlights: [Highlight], review: ArtworkReview) in
            MyFeedViewModelMapper(artworkDescription: description,
                                  highlights: highlights,
                                  artworkReview: review)
        }
        .observe(on: MainScheduler.instance)
        .subscribe { [weak self] in
            self?.myFeedViewModelMapper.accept(.loaded($0))
        } onError: { [weak self] in
            self?.myFeedViewModelMapper.accept(.failed($0))
        }
        .disposed(by: disposeBag)

    }
    
    private func fetchArtworkDescription(of artworkId: Int) -> Observable<ArtworkDescription> {
        fetchArtworkDescriptionUseCase.fetchArtworkDescription(of: artworkId)
    }
    
    private func fetchHighlight(of artworkId: Int, _ userId: String) -> Observable<[Highlight]> {
        fetchHighlightUseCase.fetchHighlight(of: artworkId, userId)
    }
    
    private func fetchArtworkReview(of artworkId: Int, _ userId: String) -> Observable<ArtworkReview> {
        fetchArtworkReviewUseCase.fetchArtwokReview(of: artworkId, userId)
    }
    
}
