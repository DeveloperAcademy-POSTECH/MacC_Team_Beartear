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

    private let weeklyArtworksCount: Int = 2
    private let artworkRepository: ArtworkRepository
    private let dateHelper: DateHelper = .init()
    
    init(_ artworkRepository: ArtworkRepository = FirebaseArtworkRepository.shared) {
        self.artworkRepository = artworkRepository
    }
    
    func requestNextArtwork(_ userLastArtworkId: Int) -> Observable<Artwork> {
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
    
    func getAllocatedArtworkNum(with user: User) -> Int {
        let userFirstLoginedDate = DateFormatter.yyyyMMddHHmmssFormatter.date(from: String(user.firstLoginedDate))!
        let today = Date()
        let weekDaysCount = dateHelper.countWeekBetweenDays(from: userFirstLoginedDate, to: today)
        let firstWeekAllocatedQuestion = getThisWeekArtworkNum(after: userFirstLoginedDate)
        if weekDaysCount == 0 {
            if userFirstLoginedDate.isInSameWeek(with: today) {
                return firstWeekAllocatedQuestion - getThisWeekArtworkNum(after: today)
            } else {
                return firstWeekAllocatedQuestion + weeklyArtworksCount - getThisWeekArtworkNum(after: today)
            }
        } else {
            let lastWeekAllocatedQuestion = weeklyArtworksCount - getThisWeekArtworkNum(after: today)
            return firstWeekAllocatedQuestion + weekDaysCount * weeklyArtworksCount + lastWeekAllocatedQuestion
        }
    }
    
    func getThisWeekArtworkNum(after date: Date) -> Int {
        let thisWeekSundayQuestionTime = dateHelper.makeDateInSameWeek(with: date, to: .sun, HHmmss: "140000")
        let thisWeekSaturdayQuestionTime = dateHelper.makeDateInSameWeek(with: date, to: .sat, HHmmss: "140000")
        
        if date.isEarlierDate(than: thisWeekSundayQuestionTime) {
            return weeklyArtworksCount
        } else if date.isEarlierDate(than: thisWeekSaturdayQuestionTime) {
            return weeklyArtworksCount - 1
        } else {
            return weeklyArtworksCount - 2
        }
    }
}
