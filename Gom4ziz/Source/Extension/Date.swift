//
//  Date.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/23.
//

import Foundation

extension Date {
    
    var formattedString: String {
        DateFormatter.yyyyMMddFormatter.string(from: self)
    }
    
    var formattedInt: Int? {
        Int(formattedString)
    }
}
