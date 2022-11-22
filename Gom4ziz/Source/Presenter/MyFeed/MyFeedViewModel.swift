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
    let artworkReviewObservable: BehaviorRelay<Loadable<ArtworkReview>> = .init(value: .notRequested)
    let artworkDescriptionObservable: BehaviorRelay<Loadable<ArtworkDescription>> = .init(value: .notRequested)
    let highlightObservable: BehaviorRelay<Loadable<[Highlight]>> = .init(value: .notRequested)
    private let disposeBag: DisposeBag = .init()
    
    init(fetchArtworkReviewUseCase: FetchArtworkReviewUseCase,
         fetchArtworkDescriptionUseCase: FetchArtworkDescriptionUseCase,
         fetchHighlightUseCase: FetchHighlightUseCase) {
        self.fetchArtworkReviewUseCase = fetchArtworkReviewUseCase
        self.fetchArtworkDescriptionUseCase = fetchArtworkDescriptionUseCase
        self.fetchHighlightUseCase = fetchHighlightUseCase
    }
    
    func fetchArtworkReview(of artworkId: Int, _ userId: String) {
        artworkReviewObservable.accept(.isLoading(last: nil))
        fetchArtworkReviewUseCase.fetchArtwokReview(of: artworkId, userId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.artworkReviewObservable.accept(.loaded($0))
            }, onError: { [weak self] in
                self?.artworkReviewObservable.accept(.failed($0))
            })
            .disposed(by: disposeBag)
    }
    
    func fetchArtworkDescription(of artworkId: Int) {
        artworkDescriptionObservable.accept(.isLoading(last: nil))
        fetchArtworkDescriptionUseCase.fetchArtworkDescription(of: artworkId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.artworkDescriptionObservable.accept(.loaded($0))
            }, onError: { [weak self] in
                self?.artworkDescriptionObservable.accept(.failed($0))
            })
            .disposed(by: disposeBag)
    }
    
    func fetchHighlight(of artworkId: Int, _ userId: String) {
        highlightObservable.accept(.isLoading(last: nil))
        fetchHighlightUseCase.fetchHighlight(of: artworkId, userId)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.highlightObservable.accept(.loaded($0))
            }, onError: { [weak self] in
                self?.highlightObservable.accept(.failed($0))
            })
            .disposed(by: disposeBag)
    }
    
}
