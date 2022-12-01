//
//  ArtworkHelper.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/12/01.
//

import Foundation

struct ArtworkHelper {
    
    private let weeklyArtworksCount: Int = 2
    private let dateHelper: DateHelper = .init()
    
    // 다음 artwork가 오게되는 날짜
    func getNextArtworkDate(from today: Date) -> Date {
        
        let thisWeekSundayArtworkTime = dateHelper.makeDateInSameWeek(with: today, to: .sun, HHmmss: "140000")
        let thisWeekSaturdayArtworkTime = dateHelper.makeDateInSameWeek(with: today, to: .sat, HHmmss: "140000")
        
        if today.isEarlierDate(than: thisWeekSundayArtworkTime) {
            return thisWeekSundayArtworkTime
        } else if today.isEarlierDate(than: thisWeekSaturdayArtworkTime) {
            return thisWeekSaturdayArtworkTime
        } else {
            let nextWeekSundayArtworkTime = dateHelper.dateAfter(days: 7, from: thisWeekSundayArtworkTime)
            return nextWeekSundayArtworkTime
        }
    }
    
    // 가입일 기준 유저에게 할당된 artwork 개수
    func getAllocatedArtworkCount(with user: User) -> Int {
        let userFirstLoginedDate = DateFormatter.yyyyMMddHHmmssFormatter.date(from: String(user.firstLoginedDate))!
        let today = Date()
        let weekDaysCount = dateHelper.countWeekBetweenDays(from: userFirstLoginedDate, to: today)
        let firstWeekAllocatedArtworkCount = getThisWeekArtworkCount(after: userFirstLoginedDate)
        if weekDaysCount == 0 {
            if userFirstLoginedDate.isInSameWeek(with: today) {
                return firstWeekAllocatedArtworkCount - getThisWeekArtworkCount(after: today)
            } else {
                return firstWeekAllocatedArtworkCount + weeklyArtworksCount - getThisWeekArtworkCount(after: today)
            }
        } else {
            let lastWeekAllocatedArtworkCount = weeklyArtworksCount - getThisWeekArtworkCount(after: today)
            return firstWeekAllocatedArtworkCount + weekDaysCount * weeklyArtworksCount + lastWeekAllocatedArtworkCount
        }
    }
    
    // 특정 날(date) 이후 해당주(date가 포함된 주)에 받게될 artwork 개수
    func getThisWeekArtworkCount(after date: Date) -> Int {
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
