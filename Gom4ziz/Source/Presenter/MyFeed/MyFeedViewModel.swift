//
//  MyFeedViewModel.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/21.
//

import Foundation

import RxCocoa
import RxSwift

final class MyFeedViewModel {
    
    private let fetchArtworkReviewUseCase: FetchArtworkReviewUseCase
    private let fetchArtworkDescriptionUseCase: FetchArtworkDescriptionUseCase
    private let fetchHighlightUseCase: FetchHighlightUseCase
    let artworkReview: BehaviorRelay<Loadable<ArtworkReview>> = .init(value: .notRequested)
    let artworkDescription: BehaviorRelay<Loadable<ArtworkDescription>> = .init(value: .notRequested)
    let highlights: BehaviorRelay<Loadable<[Highlight]>> = .init(value: .notRequested)
    private let disposeBag: DisposeBag = .init()
    
    init(fetchArtworkReviewUseCase: FetchArtworkReviewUseCase,
         fetchArtworkDescriptionUseCase: FetchArtworkDescriptionUseCase,
         fetchHighlightUseCase: FetchHighlightUseCase) {
        self.fetchArtworkReviewUseCase = fetchArtworkReviewUseCase
        self.fetchArtworkDescriptionUseCase = fetchArtworkDescriptionUseCase
        self.fetchHighlightUseCase = fetchHighlightUseCase
    }
    
    func fetchArtworkReview(of artworkId: Int, _ userId: String) {
        artworkReview.accept(.isLoading(last: nil))
        fetchArtworkReviewUseCase.fetchArtwokReview(of: artworkId, userId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.artworkReview.accept(.loaded($0))
            }, onError: { [weak self] in
                self?.artworkReview.accept(.failed($0))
            })
            .disposed(by: disposeBag)
    }
    
    func fetchArtworkDescription(of artworkId: Int) {
        artworkDescription.accept(.isLoading(last: nil))
        fetchArtworkDescriptionUseCase.fetchArtworkDescription(of: artworkId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.artworkDescription.accept(.loaded($0))
            }, onError: { [weak self] in
                self?.artworkDescription.accept(.failed($0))
            })
            .disposed(by: disposeBag)
    }
    
    func fetchHighlight(of artworkId: Int, _ userId: String) {
        highlights.accept(.isLoading(last: nil))
        fetchHighlightUseCase.fetchHighlight(of: artworkId, userId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.highlights.accept(.loaded($0))
            }, onError: { [weak self] in
                self?.highlights.accept(.failed($0))
            })
            .disposed(by: disposeBag)
    }
    
}
