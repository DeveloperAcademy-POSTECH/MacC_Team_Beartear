//
//  FetchReviewedArtworkUsecase.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/11/22.
//

import Foundation

import RxSwift

/// DB에서 리뷰된 Artwork를 불러오는 Usecase
protocol FetchReviewedArtworkUsecase {
    func requestReviewedArtworkList(of artworkId: Int) -> Observable<[Artwork]>
}

struct RealFetchReviewedArtworkUsecase: FetchReviewedArtworkUsecase {
    private let artworkRepository: ArtworkRepository
    
    init(artworkRepository: ArtworkRepository = FirebaseArtworkRepository.shared) {
        self.artworkRepository = artworkRepository
    }
    
    func requestReviewedArtworkList(of artworkId: Int) -> Observable<[Artwork]> {
        artworkRepository.fetchReviewedArtworkList(of: artworkId)
    }
}
