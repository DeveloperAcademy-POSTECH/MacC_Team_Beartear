//
//  FetchArtworkDescriptionUseCase.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/22.
//

import Foundation

import RxCocoa
import RxSwift

protocol FetchArtworkDescriptionUseCase {
    func fetchArtworkDescription(of artworkId: Int) -> Observable<ArtworkDescription>
}

struct RealFetchArtworkDescriptionUseCase: FetchArtworkDescriptionUseCase {
    
    private let artworkDescriptionRepository: ArtworkDescriptionRepository
    
    init(artworkDescriptionRepository: ArtworkDescriptionRepository = FirebaseArtworkDescriptionRepository.shared) {
        self.artworkDescriptionRepository = artworkDescriptionRepository
    }

    func fetchArtworkDescription(of artworkId: Int) -> Observable<ArtworkDescription> {
        artworkDescriptionRepository.fetchArtworkDescription(of: artworkId)
    }
    
}
