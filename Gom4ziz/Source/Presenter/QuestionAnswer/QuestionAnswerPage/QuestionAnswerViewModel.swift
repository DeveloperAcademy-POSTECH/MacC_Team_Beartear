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
    let artworkDescriptionRelay: BehaviorRelay<Loadable<ArtworkDescription>> = .init(value: .notRequested)
    let addEvent: BehaviorRelay<Loadable<Void>> = .init(value: .notRequested)
    let myAnswer: BehaviorRelay<String> = .init(value: "")
    let review: BehaviorRelay<String> = .init(value: "")
    let canUpload: BehaviorRelay<Bool> = .init(value: false)
    // TODO: Highlight도 얻을 수 있게 변경해야함!
    var highlights: [Highlight] = []

    var artworkDescription: ArtworkDescription? {
        artworkDescriptionRelay.value.value
    }

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
        self.setUpObserver()
    }

    // 디버그용 생성자
    #if DEBUG
    init() {
        self.userId = User.mockData.id
        self.artwork = Artwork.mockData
        self.artworkDescriptionRelay.accept(.loaded(ArtworkDescription.mockData))
        self.fetchDescriptionUsecase = RealFetchArtworkDescriptionUseCase()
        self.addReviewUsecase = RealArtworkReviewUsecase()
        self.setUpObserver()
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

    func addArtworkReview() {        
        addEvent.accept(.isLoading(last: nil))
        addReviewUsecase.addArtworkReview(maker: userId, of: artwork.id, review: review.value, answer: myAnswer.value, highlights: highlights)
            .subscribe(onSuccess: { [weak self] in
                self?.addEvent.accept(.loaded(()))
            }, onFailure: { [weak self] error in
                self?.addEvent.accept(.failed(error))
            })
            .disposed(by: disposeBag)
    }

}

// MARK: - 옵저버 설정
private extension QuestionAnswerViewModel {

    func setUpObserver() {

        // 질문 답변과, 감상평을 모두 작성해야 등록가능!
        Observable.combineLatest(myAnswer, review)
            .map { (answer, review) in
                !answer.isEmpty && !review.isEmpty
            }
            .bind(to: canUpload)
            .disposed(by: disposeBag)
    }

}
