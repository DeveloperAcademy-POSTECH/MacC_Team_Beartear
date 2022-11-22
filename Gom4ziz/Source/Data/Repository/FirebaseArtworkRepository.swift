//
//  FirebaseArtworkRepository.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/21.
//

import Foundation

import FirebaseFirestore
import RxSwift

protocol ArtworkRepository {
    func requestArtwork(of artworkId: Int) -> Observable<Artwork>
    func fetchReviewedArtworkList(of artworkId: Int) -> Observable<[Artwork]>
}

final class FirebaseArtworkRepository {
    static let shared: ArtworkRepository = FirebaseArtworkRepository()
    private let db: Firestore = Firestore.firestore()
    private let collectionName: String = CollectionName.artwork
}

// MARK: - ArtworkRepository protocol extension
extension FirebaseArtworkRepository: ArtworkRepository {
    func requestArtwork(of artworkId: Int) -> Observable<Artwork> {
        getArtworkRef(of: artworkId)
            .rx
            .decodable(as: Artwork.self)
    }

    func fetchReviewedArtworkList(of artworkId: Int) -> RxSwift.Observable<[Artwork]> {
        getReviewedArtworkListRef(of: artworkId)
            .rx
            .decodable(as: [Artwork].self)
    }
}

// MARK: - private extension
extension FirebaseArtworkRepository {
    func getArtworkRef(of artworkId: Int) -> DocumentReference {
        db
            .collection(collectionName)
            .document("\(artworkId)")
    }
    
    func getReviewedArtworkListRef(of artworkId: Int) -> Query {
        db
            .collection(collectionName)
            .whereField("id", isLessThanOrEqualTo: artworkId)
    }
}
