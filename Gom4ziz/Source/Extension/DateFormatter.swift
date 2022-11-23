//
//  DateFormatter.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/23.
//

import Foundation

extension DateFormatter {
    static let yyyyMMddHHmmFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmm"
        return dateFormatter
    }()
    
    static let yyyyMMddFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter
    }()
}
