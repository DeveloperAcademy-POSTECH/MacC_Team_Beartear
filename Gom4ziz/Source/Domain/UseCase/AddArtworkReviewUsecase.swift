//
//  AddArtworkReviewUsecase.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/29.
//

import Foundation

import RxSwift

protocol AddArtworkReviewUsecase {
    func addArtworkReview(maker: String, of artworkId: Int, review: String, answer: String, highlights: [Highlight]) -> Single<Void>
}

struct RealArtworkReviewUsecase: AddArtworkReviewUsecase {
    private let artworkReviewRepository: ArtworkReviewRepository

    init(artworkReviewRepository: ArtworkReviewRepository = FirebaseArtworkReviewRepository.shared) {
        self.artworkReviewRepository = artworkReviewRepository
    }

    func addArtworkReview(maker: String, of artworkId: Int, review: String, answer: String, highlights: [Highlight]) -> Single<Void> {
        let timeStamp: Int = Date().yyyyMMddHHmmssFormattedInt
        let review: ArtworkReview = ArtworkReview(review: review, timeStamp: timeStamp, uid: maker)
        let answer: QuestionAnswer = QuestionAnswer(questionAnswer: answer, timeStamp: timeStamp, uid: maker)
        return artworkReviewRepository.addArtworkReview(of: artworkId, review: review, answer: answer, highlights: highlights)
    }
}
