//
//  MyFeedViewModel.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/21.
//

import Foundation

import RxRelay
import RxSwift

struct MyFeedViewModelDTO {
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
    private let addArtworkReviewUseCase: AddArtworkReviewUsecase
    
    let myFeedViewModelRelay: BehaviorRelay<Loadable<MyFeedViewModelDTO>> = .init(value: .notRequested)
    let updateEvent: BehaviorRelay<Loadable<Void>> = .init(value: .notRequested)
    let myAnswer: BehaviorRelay<String> = .init(value: "")
    let review: BehaviorRelay<String> = .init(value: "")
    
    private let userId: String
    let artwork: Artwork
    private let disposeBag: DisposeBag = .init()
    
    init(userId: String,
         of artwork: Artwork,
         fetchArtworkReviewUseCase: FetchArtworkReviewUseCase,
         fetchArtworkDescriptionUseCase: FetchArtworkDescriptionUseCase,
         fetchHighlightUseCase: FetchHighlightUseCase,
         addArtworkReviewUseCase: AddArtworkReviewUsecase) {
        self.userId = userId
        self.artwork = artwork
        self.fetchArtworkReviewUseCase = fetchArtworkReviewUseCase
        self.fetchArtworkDescriptionUseCase = fetchArtworkDescriptionUseCase
        self.fetchHighlightUseCase = fetchHighlightUseCase
        self.addArtworkReviewUseCase = addArtworkReviewUseCase
    }
    
    func fetchMyFeed() {
        myFeedViewModelRelay.accept(.isLoading(last: nil))
        Observable.zip(fetchArtworkDescription(),
                       fetchHighlight(),
                       fetchArtworkReview())
        .map { (description: ArtworkDescription, highlights: [Highlight], review: ArtworkReview) in
            MyFeedViewModelDTO(artworkDescription: description,
                                  highlights: highlights,
                                  artworkReview: review)
        }
        .subscribe { [weak self] in
            self?.myFeedViewModelRelay.accept(.loaded($0))
            self?.review.accept($0.artworkReview)
        } onError: { [weak self] in
            self?.myFeedViewModelRelay.accept(.failed($0))
        }
        .disposed(by: disposeBag)
    }
    
    func updateArtworkReview() {
        updateEvent.accept(.isLoading(last: nil))
        let myAnswer = myAnswer.value
        let review = review.value
        let highlights = myFeedViewModelRelay.value.value?.highlights ?? []
        addArtworkReviewUseCase
            .addArtworkReview(
                maker: userId,
                of: artwork.id,
                review: review,
                answer: myAnswer,
                highlights: highlights
            )
            .subscribe(onSuccess: { [weak self] in
                self?.updateEvent.accept(.loaded(()))
            }, onFailure: { [weak self] in
                self?.updateEvent.accept(.failed($0))
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchArtworkDescription() -> Observable<ArtworkDescription> {
        fetchArtworkDescriptionUseCase.fetchArtworkDescription(of: artwork.id)
    }
    
    private func fetchHighlight() -> Observable<[Highlight]> {
        fetchHighlightUseCase.fetchHighlight(of: artwork.id, userId)
    }
    
    private func fetchArtworkReview() -> Observable<ArtworkReview> {
        fetchArtworkReviewUseCase.fetchArtwokReview(of: artwork.id, userId)
    }
    
}
