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
    private let dateHelper: DateHelper = .init()
    
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
        let today = Date.koreanNowDate
        let weekDays = dateHelper.countWeekBetweenDays(from: userFirstLoginedDate, to: today)
        if weekDays == 0 {
            return abs(getAllocatedQuestionNum(with: today) - 2)
        } else {
            let firstWeekAllocatedQuestion = getAllocatedQuestionNum(with: userFirstLoginedDate)
            let lastWeekAllocatedQuestion = abs(getAllocatedQuestionNum(with: today) - 2)
            return firstWeekAllocatedQuestion + weekDays * 2 + lastWeekAllocatedQuestion
        }
    }
    
    private func getAllocatedQuestionNum(with date: Date) -> Int {
        let thisWeekSundayQuestionTime = dateHelper.makeDateInSameWeek(with: date, to: .sun, HHmm: "1400")
        let thisWeekSaturdayQuestionTime = dateHelper.makeDateInSameWeek(with: date, to: .sat, HHmm: "1400")
        
        if !date.isLaterDate(than: thisWeekSundayQuestionTime) {
            return 2
        } else if !date.isLaterDate(than: thisWeekSaturdayQuestionTime) {
            return 1
        } else {
            return 0
        }
    }
}
