//
//  RequestArtworkUsecase.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/21.
//

import Foundation

import RxSwift

final class RequestArtworkUsecase {
    private let artworkRepository: ArtworkRepository
    
    init(_ artworkRepository: ArtworkRepository = FirebaseArtworkRepository.shared) {
        self.artworkRepository = artworkRepository
    }
    
    func requestNextArtwork(_ userLastArtworkId: Int) -> Observable<Artwork> {
        let nextArtworkId = userLastArtworkId + 1
        return artworkRepository.requestArtwork(of: nextArtworkId)
    }
}
