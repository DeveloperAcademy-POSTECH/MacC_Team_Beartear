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
    func addArtworkDescription(of artworkId: Int, _ artworkDescription: ArtworkDescription) -> Single<Void>
}

final class FirebaseArtworkDescriptionRepository {
    
    static let shared: FirebaseArtworkReviewRepository = .init()
    private let db: Firestore = Firestore.firestore()
    
}

extension FirebaseArtworkDescriptionRepository: ArtworkDescriptionRepository {
    
    func fetchArtworkDescription(of artworkId: Int, _ artworkDescriptionId: String) -> Observable<ArtworkDescription> {
        getArtworkDescripionRef(of: artworkId, artworkDescriptionId)
            .rx
            .decodable(as: ArtworkDescription.self)
    }
    
    func addArtworkDescription(of artworkId: Int, _ artworkDescription: ArtworkDescription) -> Single<Void> {
        addArtworkDescriptionRef(of: artworkId)
            .rx
            .setData(artworkDescription)
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
    
    func addArtworkDescriptionRef(of artworkId: Int) -> DocumentReference {
        db
            .collection(CollectionName.artwork)
            .document("\(artworkId)")
    }
    
}
