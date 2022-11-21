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
    func addArtworkReview(of artworkId: Int, _ artworkReview: ArtworkReview) -> Single<Void>
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

    func addArtworkReview(of artworkId: Int, _ artworkReview: ArtworkReview) -> Single<Void> {
        db.rx
            .runTransaction { [self] (transaction, errorPointer) -> Void? in
                do {
                    // artworkReview를 추가한다.
                    let artworkReviewRef: DocumentReference = getArtworkReviewRef(of: artworkId, artworkReview.uid)
                    try transaction.setData(from: artworkReview, forDocument: artworkReviewRef)

                    // user의 최신 artworkReview id를 갱신한다.
                    transaction.updateData([
                        "lastArtworkId": artworkId
                    ], forDocument: getUserRef(of: artworkReview.uid))
                    return nil
                } catch {
                    let nsError = error as NSError
                    errorPointer?.pointee = nsError
                    return nil
                }
            }
    }
}

private extension FirebaseArtworkReviewRepository {
    func getArtworkReviewRef(of artworkId: Int, _ userId: String) -> DocumentReference {
        db.collection(CollectionName.artwork).document("\(artworkId)")
            .collection(CollectionName.artworkReview).document(userId)
    }

    func getUserRef(of uid: String) -> DocumentReference {
        db.collection(CollectionName.user)
            .document(uid)
    }
}
