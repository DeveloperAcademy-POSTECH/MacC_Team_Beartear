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
    
    private init() { }
    
}

extension FirebaseHighlightRepository: HighlightRepository {
    
    func fetchHighlight(of artworkId: Int, _ userId: String) -> Observable<[Highlight]> {
        getHighlightsRef(of: artworkId, userId)
            .rx
            .decodable(as: Highlight.self)
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
