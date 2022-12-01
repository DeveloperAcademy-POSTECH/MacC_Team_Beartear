//
//  RequestArtworkUsecase.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/21.
//

import Foundation

import RxSwift

protocol RequestNextArtworkUsecase {
    func requestNextArtwork(_ userLastArtworkId: Int) -> Observable<Artwork>
}

final class RealRequestNextArtworkUsecase: RequestNextArtworkUsecase {

    private let artworkRepository: ArtworkRepository
    private let artworkHelper: ArtworkHelper = .init()
    
    init(_ artworkRepository: ArtworkRepository = FirebaseArtworkRepository.shared) {
        self.artworkRepository = artworkRepository
    }
    
    func requestNextArtwork(_ userLastArtworkId: Int) -> Observable<Artwork> {
        let allocatedArtworkNum = artworkHelper.getAllocatedArtworkCount(with: User.mockData)
        let nextArtworkId = userLastArtworkId + 1
        if shouldWaitNextArtwork(nextArtworkId: nextArtworkId, allocatedArtworkNum: allocatedArtworkNum) {
            return Observable.error(ArtworkRequestError.waitNextArtworkError)
        }

        return artworkRepository.requestArtwork(of: nextArtworkId)
    }
    
    private func shouldWaitNextArtwork(nextArtworkId: Int, allocatedArtworkNum: Int) -> Bool {
        nextArtworkId > allocatedArtworkNum
    }
}
