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
    
    // 특정 날짜의 원하는 시간 Date 만들어주는 함수, 오후 2시 -> 1400
    private func makeDate(with date: Date, HHmm: String) -> Date {
        let dateString = DateFormatter.yyyyMMddFormatter.string(from: date)
        let dateAndHour = dateString + HHmm
        return DateFormatter.yyyyMMddHHmmFormatter.date(from: dateAndHour)!
    }
    
    func makeDateInSameWeek(with comparingDate: Date, to comparedWeekday: IndexOfWeekday, HHmm: String) -> Date {
        let distanceToDay = getDistanceBetweenDays(from: comparingDate, to: comparedWeekday)
        let sameWeekParticularDate = dateAfter(days: distanceToDay, from: comparingDate)
        let sameWeekParticularDateParticularTime = makeDate(with: sameWeekParticularDate, HHmm: HHmm)
        return sameWeekParticularDateParticularTime
    }
    
    func countWeekBetweenDays(from firstDate: Date, to today: Date) -> Int {
        
        let saturdayInFirstDateWeek = makeDateInSameWeek(with: firstDate, to: .sat, HHmm: "1400")
        let saturdayInTodayWeek = makeDateInSameWeek(with: today, to: .sat, HHmm: "1400")
        
        // 두 날짜가 같은 week에 속하는 경우
        if case .orderedSame = saturdayInFirstDateWeek.compare(saturdayInTodayWeek) {
            return 0
        } else {
            let diffDays = Calendar.current.dateComponents([.day], from: makeDate(with: firstDate, HHmm: "0000"), to: makeDate(with: today, HHmm: "0000")).day!
            let firstWeekRemainDays = weekdays - firstDate.weekday!
            let lastWeekPassedDays = today.weekday!
            
            let days = diffDays - (firstWeekRemainDays + lastWeekPassedDays)
            return days / 7
        }
    }
}
