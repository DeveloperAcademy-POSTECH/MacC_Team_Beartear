//
//  FetchArtworkReviewUsecase.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/21.
//

import Foundation

import RxSwift

protocol FetchArtworkReviewUseCase {
    func fetchArtwokReview(of artworkId: Int, _ userId: String) -> Observable<ArtworkReview>
}

struct RealFetchArtworkReviewUseCase: FetchArtworkReviewUseCase {
    private let artworkReviewRepository: ArtworkReviewRepository
    
    init(artworkReviewRepository: ArtworkReviewRepository = FirebaseArtworkReviewRepository.shared) {
        self.artworkReviewRepository = artworkReviewRepository
    }
    
    func fetchArtwokReview(of artworkId: Int, _ userId: String) -> Observable<ArtworkReview> {
        artworkReviewRepository.fetchArtworkReview(of: artworkId, userId)
    }
}
