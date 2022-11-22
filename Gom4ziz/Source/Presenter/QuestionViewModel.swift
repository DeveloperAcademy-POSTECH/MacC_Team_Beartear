//
//  QuestionViewModel.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/21.
//

import Foundation

import RxCocoa
import RxSwift

final class QuestionViewModel {

    private let requestNextArtworkUsecase: RequestNextArtworkUsecase
    private let disposeBag: DisposeBag = .init()
    
    let artwork: BehaviorRelay<WeeklyArtworkStatus> = .init(value: .notRequested)
    
    init(requestNextQuestionUsecase: RequestNextArtworkUsecase) {
        self.requestNextArtworkUsecase = requestNextQuestionUsecase
    }
    
    func requestArtwork(_ userLastArtworkId: Int) {
        artwork.accept(.loading)
        requestNextArtworkUsecase.requestNextArtwork(userLastArtworkId)
            .subscribe(onNext: { [weak self] in
                if $0 == Artwork.empty {
                    self?.artwork.accept(.noMoreData)
                } else {
                    let loadedStatus = WeeklyArtworkStatus.loaded($0)
                    self?.artwork.accept(loadedStatus)
                }
            },
                       onError: { [weak self] error in
                let failedStatus = WeeklyArtworkStatus.failed(error)
                self?.artwork.accept(failedStatus)
            })
            .disposed(by: disposeBag)
    }
}
