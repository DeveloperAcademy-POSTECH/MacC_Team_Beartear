//
//  Date.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/23.
//

import Foundation

extension Date {
    
    var yyyyMMddHHmmssFormattedString: String {
        DateFormatter.yyyyMMddHHmmssFormatter.string(from: self)
    }
    
    var yyyyMMddHHmmssFormattedInt: Int? {
        Int(yyyyMMddHHmmssFormattedString)
    }
    
    var weekday: Int? {
        Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    
    func isEarlierDate(than date: Date) -> Bool {
        self.timeIntervalSince(date) >= 0.0 ? false : true
    }
    
    func isInSameYear(with date: Date) -> Bool {
        Calendar.current.isDate(self, equalTo: date, toGranularity: .year)
    }
    
    func isInSameWeek(with date: Date) -> Bool {
        Calendar.current.isDate(self, equalTo: date, toGranularity: .weekOfYear) && isInSameYear(with: date)
    }
}

enum IndexOfWeekday: Int {
    case sun = 1
    case mon, tue, wed, thu, fri, sat
}
