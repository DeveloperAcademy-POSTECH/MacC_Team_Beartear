//
//  DateFormatter.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/23.
//

import Foundation

extension DateFormatter {
    static let yyyyMMddHHmmssFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        return dateFormatter
    }()
    
    static let yyyyMMddFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        return dateFormatter
    }()
}
