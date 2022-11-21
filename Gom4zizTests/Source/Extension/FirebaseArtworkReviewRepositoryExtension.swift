//
//  FirebaseArtworkReviewRepositoryExtension.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/21.
//

@testable import Gom4ziz

import RxSwift

extension FirebaseArtworkReviewRepository {
    func deleteArtworkReview(of artworkId: Int, review: ArtworkReview) -> Single<Void> {
        getArtworkReviewRef(of: artworkId, review.uid)
            .rx
            .deleteDocument()
    }
}
