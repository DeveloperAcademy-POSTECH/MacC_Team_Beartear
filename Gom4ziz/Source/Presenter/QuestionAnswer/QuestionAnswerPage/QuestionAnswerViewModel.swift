//
//  QuestionAnswerViewModel.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/23.
//

import RxSwift
import RxRelay

final class QuestionAnswerViewModel {

    // MARK: - 유즈케이스
    private let fetchDescriptionUsecase: FetchArtworkDescriptionUseCase
    // MARK: - 프로퍼티
    private let disposeBag: DisposeBag = .init()
    let artwork: Artwork
    let artworkDescriptionRelay: BehaviorRelay<Loadable<ArtworkDescription>> = .init(value: .notRequested)
    var myAnswer: String = ""
    var artworkDescription: ArtworkDescription? {
        artworkDescriptionRelay.value.value
    }

    init(
        of artwork: Artwork,
        fetchDescriptionUsecase: FetchArtworkDescriptionUseCase = RealFetchArtworkDescriptionUseCase()
    ) {
        self.artwork = artwork
        self.fetchDescriptionUsecase = fetchDescriptionUsecase
    }

    // 디버그용 생성자
    #if DEBUG
    init(
        of artwork: Artwork = .mockData,
        artworkDescription: ArtworkDescription = .mockData
    ) {
        self.artwork = artwork
        self.artworkDescriptionRelay.accept(.loaded(artworkDescription))
        self.fetchDescriptionUsecase = RealFetchArtworkDescriptionUseCase()
    }
    #endif

    func fetchArtworkDescription() {
        artworkDescriptionRelay.accept(.isLoading(last: nil))
        fetchDescriptionUsecase.fetchArtworkDescription(of: artwork.id)
            .subscribe(onNext: { [weak self] description in
                self?.artworkDescriptionRelay.accept(.loaded(description))
            }, onError: { [weak self] error in
                self?.artworkDescriptionRelay.accept(.failed(error))
            })
            .disposed(by: disposeBag)
    }

}
