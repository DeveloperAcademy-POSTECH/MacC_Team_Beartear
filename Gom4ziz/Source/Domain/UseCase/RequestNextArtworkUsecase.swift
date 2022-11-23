//
//  RequestArtworkUsecase.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/21.
//

import Foundation

import RxSwift

final class RequestNextArtworkUsecase {

    private let artworkRepository: ArtworkRepository
    
    init(_ artworkRepository: ArtworkRepository = FirebaseArtworkRepository.shared) {
        self.artworkRepository = artworkRepository
    }
    
    func requestNextArtwork(_ userLastArtworkId: Int) -> Observable<Artwork> {
        // TODO: 유저에게 할당된 작품의 범위 이상을 요청하는 경우에 대한 실패처리
        // 일단 할당된 작품 범위의 값(allocatedArtworkNum)을 임의로 할당해준다

        let allocatedArtworkNum = getAllocatedArtworkNum(with: User.mockData)
        let nextArtworkId = userLastArtworkId + 1
        if isNoMoreArtworkToSee(nextArtworkId: nextArtworkId, allocatedArtworkNum: allocatedArtworkNum) {
            return Observable.error(RequestError.noMoreDataError)
        }

        return artworkRepository.requestArtwork(of: nextArtworkId)
    }
    
    private func isNoMoreArtworkToSee(nextArtworkId: Int, allocatedArtworkNum: Int) -> Bool {
        nextArtworkId > allocatedArtworkNum
    }
    
    private func getAllocatedArtworkNum(with user: User) -> Int {
        let userFirstLoginedDate = DateFormatter.yyyyMMddHHmmFormatter.date(from: String(user.firstLoginedDate))!
        return 100
    }
}
