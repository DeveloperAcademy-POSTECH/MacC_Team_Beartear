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
                let loadedStatus = WeeklyArtworkStatus.loaded($0)
                self?.artwork.accept(loadedStatus)
            },
                       onError: { [weak self] error in
                guard let status = self?.getArtworkStatus(error) else { return }
                self?.artwork.accept(status)
            })
            .disposed(by: disposeBag)
    }
}

private extension QuestionViewModel {
    
    func getArtworkStatus(_ error: Error) -> WeeklyArtworkStatus? {
        let failedStatus = WeeklyArtworkStatus.failed(error)
        guard case let .failed(error) = failedStatus else {
            return nil
        }
        guard let error = error as? RequestError, error == .noMoreDataError else {
            return failedStatus
        }
        return .noMoreData
    }
}

