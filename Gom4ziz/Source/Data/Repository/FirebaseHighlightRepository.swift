//
//  FirebaseHighlightRepository.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/22.
//

import Foundation

import FirebaseFirestore
import RxSwift

protocol HighlightRepository {
    func fetchHighlight(of artworkId: Int, _ userId: String) -> Observable<[Highlight]>
}

final class FirebaseHighlightRepository {
    
    static let shared: HighlightRepository = FirebaseHighlightRepository()
    private let db: Firestore = Firestore.firestore()
    private var cache: Set<CacheKey> = []
    private init() { }

    struct CacheKey: Hashable {
        let artworkId: Int
        let userId: String
    }
}

extension FirebaseHighlightRepository: HighlightRepository {
    
    func fetchHighlight(of artworkId: Int, _ userId: String) -> Observable<[Highlight]> {
        let cacheKey: CacheKey = CacheKey(artworkId: artworkId, userId: userId)
        let source: FirestoreSource = cache.contains(cacheKey) ? .cache: .server

        return getHighlightsRef(of: artworkId, userId)
            .rx
            .decodable(as: Highlight.self, source: source)
            .do(onNext: { _ in
                self.cache.insert(cacheKey)
            })
    }

}

private extension FirebaseHighlightRepository {
    
    func getHighlightsRef(of artworkId: Int, _ userId: String) -> CollectionReference {
        db
            .collection(CollectionName.artwork)
            .document("\(artworkId)")
            .collection(CollectionName.artworkReview)
            .document(userId)
            .collection(CollectionName.highlight)
    }
    
}
