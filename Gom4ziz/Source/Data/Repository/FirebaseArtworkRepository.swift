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
}

final class FirebaseArtworkRepository: ArtworkRepository {
    
    static let shared: ArtworkRepository = FirebaseArtworkRepository()
    private let db: Firestore = Firestore.firestore()
    private let collectionName: String = CollectionName.artwork
        
    func requestArtwork(of artworkId: Int) -> Observable<Artwork> {
        getArtworkRef(of: artworkId)
            .rx
            .decodable(as: Artwork.self)
    }
}

extension FirebaseArtworkRepository {
    func getArtworkRef(of artworkId: Int) -> DocumentReference {
        db
            .collection(collectionName)
            .document("\(artworkId)")
    }
}
