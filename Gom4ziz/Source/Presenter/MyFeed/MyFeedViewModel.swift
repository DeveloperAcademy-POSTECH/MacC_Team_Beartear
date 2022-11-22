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
    let artworkReview: BehaviorRelay<Loadable<ArtworkReview>> = .init(value: .notRequested)
    private let disposeBag: DisposeBag = .init()
    
    init(fetchArtworkReviewUseCase: FetchArtworkReviewUseCase) {
        self.fetchArtworkReviewUseCase = fetchArtworkReviewUseCase
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
}
