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
    
    func isLaterDate(than date: Date) -> Bool {
        return self.timeIntervalSince(date) >= 0.0 ? true : false
    }
}

enum IndexOfWeekday: Int {
    case mon = 1
    case tue, wed, thu, fri, sat, sun
}
