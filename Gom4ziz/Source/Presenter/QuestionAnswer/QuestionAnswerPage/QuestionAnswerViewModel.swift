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
    private let addReviewUsecase: AddArtworkReviewUsecase
    // MARK: - 프로퍼티
    private let disposeBag: DisposeBag = .init()
    private let userId: String
    let artwork: Artwork
    // MARK: - Rx Relays
    let artworkDescriptionRelay: BehaviorRelay<Loadable<ArtworkDescription>> = .init(value: .notRequested)
    let addEvent: PublishRelay<Loadable<Void>> = .init()
    let myAnswer: BehaviorRelay<String> = .init(value: "")
    let review: BehaviorRelay<String> = .init(value: "")
    let highlights: BehaviorRelay<[Highlight]> = .init(value: [])

    init(
        userId: String,
        of artwork: Artwork,
        fetchDescriptionUsecase: FetchArtworkDescriptionUseCase = RealFetchArtworkDescriptionUseCase(),
        addReviewUsecase: AddArtworkReviewUsecase = RealArtworkReviewUsecase()
    ) {
        self.userId = userId
        self.artwork = artwork
        self.fetchDescriptionUsecase = fetchDescriptionUsecase
        self.addReviewUsecase = addReviewUsecase
    }

    // 디버그용 생성자
    #if DEBUG
    init() {
        self.userId = User.mockData.id
        self.artwork = Artwork.mockData
        self.artworkDescriptionRelay.accept(.loaded(ArtworkDescription.mockData))
        self.fetchDescriptionUsecase = RealFetchArtworkDescriptionUseCase()
        self.addReviewUsecase = RealArtworkReviewUsecase()
    }
    #endif

    /// 작품 상세 설명을 불러오는 함수
    func fetchArtworkDescription() {
        // 먼저 작품 상세설명을 로딩 상태로 바꿈
        artworkDescriptionRelay.accept(.isLoading(last: nil))
        // 작품 상세 정보 fetch 요청
        fetchDescriptionUsecase.fetchArtworkDescription(of: artwork.id)
            .subscribe(onNext: { [weak self] description in
                self?.artworkDescriptionRelay.accept(.loaded(description))
            }, onError: { [weak self] error in
                self?.artworkDescriptionRelay.accept(.failed(error))
            })
            .disposed(by: disposeBag)
    }

    /// 질문 답변, 감상평, 하이라이트들을 DB에 업로드하는 함수
    func addArtworkReview() {
        // 먼저 업로드 이벤트를 Loading 상태로 바꿈
        addEvent.accept(.isLoading(last: nil))
        let review = review.value
        let answer = myAnswer.value
        let highlights = highlights.value
        // DB 업로드 요청
        addReviewUsecase.addArtworkReview(maker: userId, of: artwork.id, review: review, answer: answer, highlights: highlights)
            .subscribe(onSuccess: { [weak self] in
                // 업로드 이벤트를 마무리한다.
                self?.addEvent.accept(.loaded(()))
            }, onFailure: { [weak self] error in
                // 업로드 도중 실패 시
                self?.addEvent.accept(.failed(error))
            })
            .disposed(by: disposeBag)
    }

}
