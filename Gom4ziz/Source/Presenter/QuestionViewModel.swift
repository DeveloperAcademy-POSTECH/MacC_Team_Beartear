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
    
    let artwork: PublishSubject<Artwork> = .init()
    
    init(requestArtworkUsecase: RequestArtworkUsecase) {
        self.requestArtworkUsecase = requestArtworkUsecase
    }
    
    func requestArtwork(_ userLastArtworkId: Int) {
        requestArtworkUsecase.requestNextArtwork(userLastArtworkId)
            .subscribe(onNext: { [weak self] in
                self?.artwork.onNext($0)
            })
            .disposed(by: disposeBag)
    }
}
