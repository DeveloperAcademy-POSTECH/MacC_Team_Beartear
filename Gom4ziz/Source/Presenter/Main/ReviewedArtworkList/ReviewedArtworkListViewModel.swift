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
    private let user: User
    let reviewedArtworkListCellListObservable: BehaviorRelay<Loadable<[ReviewedArtworkListCellViewModel]>> = .init(value: .notRequested)
    
    private let disposeBag: DisposeBag = .init()
    
    init(
        fetchReviewedArtworkUsecase: FetchReviewedArtworkUsecase = RealFetchReviewedArtworkUsecase(),
        fetchQuestionAnswerUsecase: FetchQuestionAnswerUsecase = RealFetchQuestionAnswerUsecase(),
        user: User
    ) {
        self.fetchReviewedArtworkUsecase = fetchReviewedArtworkUsecase
        self.fetchQuestionAnswerUsecase = fetchQuestionAnswerUsecase
        self.user = user
    }
    
    func fetchReviewedArtworkListCellList() {
        reviewedArtworkListCellListObservable.accept(.isLoading(last: nil))
        Observable.zip(fetchReviewedArtworkUsecase.requestReviewedArtworkList(before: user.lastArtworkId), fetchQuestionAnswerUsecase.fetchQuestionAnswerList(for: user.id, before: user.lastArtworkId))
            .map { (artworkList, questionAnswerList) in
                (artworkList.indices).map {
                    let artwork = artworkList[$0]
                    let answer = questionAnswerList[$0]
                    return ReviewedArtworkListCellViewModel(
                        artwork: artwork,
                        questionAnswer: answer
                    )
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
