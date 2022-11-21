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
    func requestArtwork(of artworkId: String) -> Observable<Artwork>
}

final class FirebaseArtworkRepository: ArtworkRepository {
    
    static let shared: ArtworkRepository = FirebaseArtworkRepository()
    private let db: Firestore = Firestore.firestore()
    private let collectionName: String = CollectionName.artwork
    
    private init() { }
    
    func requestArtwork(of artworkId: String) -> Observable<Artwork> {
        getArtworkRef(of: artworkId)
            .rx
            .decodable(as: Artwork.self)
    }
}

private extension FirebaseArtworkRepository {
    func getArtworkRef(of artworkId: String) -> DocumentReference {
        db.collection(collectionName).document(artworkId)
    }
}