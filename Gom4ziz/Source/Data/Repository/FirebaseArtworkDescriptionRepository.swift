//
//  FirebaseArtworkDescriptionRepository.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/22.
//

import Foundation

import FirebaseFirestore
import RxCocoa
import RxSwift

protocol ArtworkDescriptionRepository {
    func fetchArtworkDescription(of artworkId: Int) -> Observable<ArtworkDescription>
}

final class FirebaseArtworkDescriptionRepository {
    
    static let shared: FirebaseArtworkDescriptionRepository = .init()
    private let db: Firestore = Firestore.firestore()
    private var cache: Set<Int> = []

}

extension FirebaseArtworkDescriptionRepository: ArtworkDescriptionRepository {
    
    func fetchArtworkDescription(of artworkId: Int) -> Observable<ArtworkDescription> {
        let source: FirestoreSource = cache.contains(artworkId) ? .cache: .server

        return getArtworkDescripionRef(of: artworkId)
            .rx
            .decodable(as: ArtworkDescription.self, source: source)
            .do(onNext: { _ in self.cache.insert(artworkId) })
    }
    
}

extension FirebaseArtworkDescriptionRepository {
    
    func getArtworkDescripionRef(of artworkId: Int) -> DocumentReference {
        db
            .collection(CollectionName.artworkDescription)
            .document("\(artworkId)")
    }
    
}
