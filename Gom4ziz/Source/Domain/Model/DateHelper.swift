//
//  DateHelper.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/23.
//

import Foundation

struct DateHelper {

    // 특정 날짜와 해당 날짜가 있는 주의 특정 요일 사이의 차이(+, -)를 나타내는 함수
    func getDistanceBetweenDays(from comparingDate: Date, to comparedWeekday: IndexOfWeekday) -> Int? {
        let indexOfComparedWeekday = comparedWeekday.rawValue
        let indexOfComparingWeekday = comparingDate.weekday!
        return indexOfComparedWeekday - indexOfComparingWeekday
    }
    
    // 특정 날짜(+, -) 만큼 기준 날짜에 더해서 Date 만들어주는 함수
    func dateAfter(days: Int, from comparedDate: Date) -> Date? {
        return Calendar.current.date(byAdding: .day, value: days, to: comparedDate)
    }
    
    // 특정 날짜의 원하는 시간 Date 만들어주는 함수
    func makeDate(with date: Date, HHmm: String) -> Date? {
        let dateString = DateFormatter.yyyyMMddFormatter.string(from: date)
        let dateAndHour = dateString + HHmm
        return DateFormatter.yyyyMMddHHmmFormatter.date(from: dateAndHour)
    }
}
