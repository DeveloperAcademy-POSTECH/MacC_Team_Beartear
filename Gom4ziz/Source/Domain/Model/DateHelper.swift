//
//  DateHelper.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/23.
//

import Foundation

struct DateHelper {

    private let weekdays: Int = 7
    
    // 특정 날짜와 해당 날짜가 있는 주의 특정 요일 사이의 차이(+, -)를 나타내는 함수
    private func getDistanceBetweenDays(from comparingDate: Date, to comparedWeekday: IndexOfWeekday) -> Int {
        let indexOfComparedWeekday = comparedWeekday.rawValue
        let indexOfComparingWeekday = comparingDate.weekday!
        return indexOfComparedWeekday - indexOfComparingWeekday
    }
    
    // 특정 날짜(+, -) 만큼 기준 날짜에 더해서 Date 만들어주는 함수
    func dateAfter(days: Int, from comparedDate: Date) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: comparedDate)!
    }
    
    // 특정 날짜의 원하는 시간 Date 만들어주는 함수, 오후 2시 -> 140000
    private func makeDate(with date: Date, HHmmss: String) -> Date {
        let dateString = DateFormatter.yyyyMMddFormatter.string(from: date)
        let dateAndHour = dateString + HHmmss
        return DateFormatter.yyyyMMddHHmmssFormatter.date(from: dateAndHour)!
    }
    
    private func makeDateInSameWeek(with comparingDate: Date, to comparedWeekday: IndexOfWeekday, HHmmss: String) -> Date {
        let distanceToDay = getDistanceBetweenDays(from: comparingDate, to: comparedWeekday)
        let sameWeekParticularDate = dateAfter(days: distanceToDay, from: comparingDate)
        let sameWeekParticularDateParticularTime = makeDate(with: sameWeekParticularDate, HHmmss: HHmmss)
        return sameWeekParticularDateParticularTime
    }
    
    private func countWeekBetweenDays(from firstDate: Date, to today: Date) -> Int {
        
        let saturdayInFirstDateWeek = makeDateInSameWeek(with: firstDate, to: .sat, HHmmss: "140000")
        let saturdayInTodayWeek = makeDateInSameWeek(with: today, to: .sat, HHmmss: "140000")
        
        // 두 날짜가 같은 날짜인 경우를 기준으로 분기처리
        if case .orderedSame = saturdayInFirstDateWeek.compare(saturdayInTodayWeek) {
            return 0
        } else {
            let diffDays = Calendar.current.dateComponents([.day], from: makeDate(with: firstDate, HHmmss: "000000"), to: makeDate(with: today, HHmmss: "000000")).day!
            let firstWeekRemainDays = weekdays - firstDate.weekday!
            let lastWeekPassedDays = today.weekday!
            
            let days = diffDays - (firstWeekRemainDays + lastWeekPassedDays)
            return days / 7
        }
    }
}
