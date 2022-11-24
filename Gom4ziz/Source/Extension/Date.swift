//
//  Date.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/23.
//

import Foundation

extension Date {
    
    var yyyyMMddHHmmFormattedString: String {
        DateFormatter.yyyyMMddHHmmFormatter.string(from: self)
    }
    
    var yyyyMMddHHmmFormattedInt: Int? {
        Int(yyyyMMddHHmmFormattedString)
    }
    
    var weekday: Int? {
        Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func isEarlierDate(than date: Date) -> Bool {
        return self.timeIntervalSince(date) >= 0.0 ? false : true
    }
    
    func isInSameWeek(with date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .weekOfYear)
    }
    
    var convertedKoreanDate: Date {
        let hourToSeconds = 3600
        let hourDiffFromGreenwichToKorea = 9
        let greenwichKoreaDiffSeconds = TimeInterval(hourToSeconds * hourDiffFromGreenwichToKorea)

        return self.addingTimeInterval(greenwichKoreaDiffSeconds)
    }
    
    static var koreanNowDate: Date {
        Date(timeIntervalSinceNow: 3600 * 9)
    }
}

enum IndexOfWeekday: Int {
    case sun = 1
    case mon, tue, wed, thu, fri, sat
}
