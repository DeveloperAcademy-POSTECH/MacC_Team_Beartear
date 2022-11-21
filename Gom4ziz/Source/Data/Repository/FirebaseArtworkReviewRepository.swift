//
//  FirebaseArtworkReviewRepository.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/21.
//

import Foundation

import FirebaseFirestore
import RxSwift
import RxRelay

protocol ArtworkReviewRepository {
    func fetchArtworkReview(of artworkId: Int, _ userId: String) -> Observable<ArtworkReview>
}

final class FirebaseArtworkReviewRepository {
    static let shared: ArtworkReviewRepository = FirebaseArtworkReviewRepository()
    private let db: Firestore = Firestore.firestore()
    
    private init() { }
}

extension FirebaseArtworkReviewRepository: ArtworkReviewRepository {
    func fetchArtworkReview(of artworkId: Int, _ userId: String) -> Observable<ArtworkReview> {
        getArtworkReviewRef(of: artworkId, userId)
            .rx
            .decodable(as: ArtworkReview.self)
    }
}

private extension FirebaseArtworkReviewRepository {
    func getArtworkReviewRef(of artworkId: Int, _ userId: String) -> DocumentReference {
        db.collection(CollectionName.artwork).document("\(artworkId)")
            .collection(CollectionName.artworkReview).document(userId)
    }
}
