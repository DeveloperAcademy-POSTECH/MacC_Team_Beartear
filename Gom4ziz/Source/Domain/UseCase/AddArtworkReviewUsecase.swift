//
//  AddArtworkReviewUsecase.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/29.
//

import RxSwift

protocol AddArtworkReviewUsecase {
    func addArtworkReview(of artworkId: Int, review: ArtworkReview, answer: QuestionAnswer, highlights: [Highlight]) -> Single<Void>
}

struct RealArtworkReviewUsecase: AddArtworkReviewUsecase {
    private let artworkReviewRepository: ArtworkReviewRepository

    init(artworkReviewRepository: ArtworkReviewRepository = FirebaseArtworkReviewRepository.shared) {
        self.artworkReviewRepository = artworkReviewRepository
    }

    func addArtworkReview(of artworkId: Int, review: ArtworkReview, answer: QuestionAnswer, highlights: [Highlight]) -> Single<Void> {
        artworkReviewRepository.addArtworkReview(of: artworkId, review: review, answer: answer, highlights: highlights)
    }
}
