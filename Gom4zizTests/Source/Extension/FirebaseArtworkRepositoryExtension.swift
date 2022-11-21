//
//  FirebaseArtworkRepositoryTests.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/21.
//

@testable import Gom4ziz

import RxSwift

extension FirebaseArtworkRepository {

    func addArtwork(artwork: Artwork) -> Single<Void> {
        getArtworkRef(of: String(artwork.id))
            .rx
            .setData(artwork)
    }
    func deleteArtwork(artwork: Artwork) -> Single<Void> {
        getArtworkRef(of: String(artwork.id))
            .rx
            .deleteDocument()
    }
}
