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

    func addArtworkReview(
        of artworkId: Int,
        review: ArtworkReview,
        answer: QuestionAnswer,
        highlights: [Highlight]
    ) -> Single<Void>

}

final class FirebaseArtworkReviewRepository {
    static let shared: FirebaseArtworkReviewRepository = FirebaseArtworkReviewRepository()
    private let db: Firestore = Firestore.firestore()
    private var cache: Set<CacheKey> = .init()

    struct CacheKey: Hashable {
        let userId: String
        let artworkId: Int
    }
}

extension FirebaseArtworkReviewRepository: ArtworkReviewRepository {

    func fetchArtworkReview(of artworkId: Int, _ userId: String) -> Observable<ArtworkReview> {
        let cacheKey: CacheKey = .init(userId: userId, artworkId: artworkId)

        let source: FirestoreSource = cache.contains(cacheKey) ? .cache: .server

        return getArtworkReviewRef(of: artworkId, userId)
            .rx
            .decodable(as: ArtworkReview.self, source: source)
            .do(onNext: { _ in self.cache.insert(cacheKey)} )
    }

    func addArtworkReview(
        of artworkId: Int,
        review: ArtworkReview,
        answer: QuestionAnswer,
        highlights: [Highlight]
    ) -> Single<Void> {

        let artworkReviewRef: DocumentReference = getArtworkReviewRef(of: artworkId, review.uid)
        let answerRef: DocumentReference = getQuestionAnswerRef(of: artworkId, review.uid)
        let userRef: DocumentReference = getUserRef(of: review.uid)
        let highlightsRefs: [DocumentReference] = highlights.map { getHighlightsRef(of: artworkId, review.uid, $0.start) }

        // 아트워크 리뷰를 업데이트하거나 추가하면, 다시 서버에서 불러와야 하므로 캐시키를 지운다.
        let cacheKey: CacheKey = .init(userId: review.uid, artworkId: artworkId)
        cache.remove(cacheKey)

        return db.rx
            .runTransaction {  (transaction, errorPointer) -> Void? in
                do {
                    // artworkReview를 추가한다.
                    try transaction.setData(from: review, forDocument: artworkReviewRef)
                    // questionAnswer를 추가한다.
                    try transaction.setData(from: answer, forDocument: answerRef)
                    // 하이라이트들을 추가한다.
                    for index in highlightsRefs.indices {
                        try transaction.setData(from: highlights[index], forDocument: highlightsRefs[index])
                    }
                    // user의 최신 artworkReview id를 갱신한다.
                    transaction.updateData([
                        "lastArtworkId": artworkId
                    ], forDocument: userRef)
                    return nil
                } catch {
                    let nsError = error as NSError
                    errorPointer?.pointee = nsError
                    return nil
                }
            }
    }
}

extension FirebaseArtworkReviewRepository {

    func getArtworkReviewRef(of artworkId: Int, _ userId: String) -> DocumentReference {
        db
            .collection(CollectionName.artwork)
            .document("\(artworkId)")
            .collection(CollectionName.artworkReview)
            .document(userId)
    }

    func getHighlightsRef(of artworkId: Int, _ userId: String, _ start: Int) -> DocumentReference {
        getArtworkReviewRef(of: artworkId, userId)
            .collection(CollectionName.highlight)
            .document(String(start))
    }

    func getQuestionAnswerRef(of artworkId: Int, _ userId: String) -> DocumentReference {
        db
            .collection(CollectionName.artwork)
            .document(String(artworkId))
            .collection(CollectionName.questionAnswer)
            .document(userId)
    }

    func getUserRef(of uid: String) -> DocumentReference {
        db
            .collection(CollectionName.user)
            .document(uid)
    }
    
}
