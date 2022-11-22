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
    private let requestArtworkUsecase: RequestArtworkUsecase
    private let disposeBag: DisposeBag = .init()
    
    let artwork: BehaviorSubject<WeeklyArtworkStatus> = .init(value: .notRequested)
    
    init(requestArtworkUsecase: RequestArtworkUsecase) {
        self.requestArtworkUsecase = requestArtworkUsecase
    }
    
    func requestArtwork(_ artworkId: Int) {
        artwork.onNext(.loading)
        requestArtworkUsecase.requestNextArtwork(artworkId)
            .subscribe(onNext: { [weak self] in
                let loadedStatus = WeeklyArtworkStatus.loaded($0)
                self?.artwork.onNext(loadedStatus)
            },
                       onError: { error in
                // TODO: error의 종류에 따라 다른 처리, 해당 document가 없다는 에러일 경우 .noMoreData 방출 처리
            })
            .disposed(by: disposeBag)
    }
}
