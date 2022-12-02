//
//  ReviewedArtworkListViewModel.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/11/28.
//

import Foundation

import RxCocoa
import RxSwift

final class ReviewedArtworkListViewModel {
    
    private let fetchReviewedArtworkUsecase: FetchReviewedArtworkUsecase
    private let fetchQuestionAnswerUsecase: FetchQuestionAnswerUsecase
    
    let reviewedArtworkListCellListObservable: BehaviorRelay<Loadable<[ReviewedArtworkListCellViewModel]>> = .init(value: .notRequested)
    
    private let disposeBag: DisposeBag = .init()
    
    init(fetchReviewedArtworkUsecase: FetchReviewedArtworkUsecase = RealFetchReviewedArtworkUsecase(),
         fetchQuestionAnswerUsecase: FetchQuestionAnswerUsecase = RealFetchQuestionAnswerUsecase()) {
        self.fetchReviewedArtworkUsecase = fetchReviewedArtworkUsecase
        self.fetchQuestionAnswerUsecase = fetchQuestionAnswerUsecase
    }
    
    func fetchReviewedArtworkListCellList(for userId: String, before artworkId: Int) {
        reviewedArtworkListCellListObservable.accept(.isLoading(last: nil))
        Observable.zip(fetchReviewedArtworkUsecase.requestReviewedArtworkList(before: artworkId), fetchQuestionAnswerUsecase.fetchQuestionAnswerList(for: userId, before: artworkId))
            .map { (artworkList, questionAnswerList) in
                Array(0..<artworkId).map {
                    ReviewedArtworkListCellViewModel(artwork: artworkList[$0], questionAnswer: questionAnswerList[$0])
                }
            }
            .subscribe(onNext: { [weak self] in
                self?.reviewedArtworkListCellListObservable.accept(.loaded($0))
            }, onError: { [weak self] in
                self?.reviewedArtworkListCellListObservable.accept(.failed($0))
            })
            .disposed(by: disposeBag)
    }
    
}
