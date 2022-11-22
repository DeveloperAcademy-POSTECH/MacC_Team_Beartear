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
    func fetchArtworkDescription(of artworkId: Int, _ artworkDescriptionId: String) -> Observable<ArtworkDescription>
}

final class FirebaseArtworkDescriptionRepository {
    
    static let shared: FirebaseArtworkDescriptionRepository = .init()
    private let db: Firestore = Firestore.firestore()
    
}

extension FirebaseArtworkDescriptionRepository: ArtworkDescriptionRepository {
    
    func fetchArtworkDescription(of artworkId: Int, _ artworkDescriptionId: String) -> Observable<ArtworkDescription> {
        getArtworkDescripionRef(of: artworkId, artworkDescriptionId)
            .rx
            .decodable(as: ArtworkDescription.self)
    }
    
}

extension FirebaseArtworkDescriptionRepository {
    
    func getArtworkDescripionRef(of artworkId: Int, _ artworkDescriptionId: String) -> DocumentReference {
        db
            .collection(CollectionName.artwork)
            .document("\(artworkId)")
            .collection(CollectionName.artworkDescription)
            .document(artworkDescriptionId)
    }
    
}
