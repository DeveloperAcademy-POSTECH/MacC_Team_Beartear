//
//  TimeDiffHandler.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/22.
//

import Foundation

struct TimeDiffHandler {
    
    var dateComponentsSet: Set<Calendar.Component>
    
    func getDateComponentsDiff(from comparingDate: Date, to comparedDate: Date) -> DateComponents {
        return Calendar.current.dateComponents(dateComponentsSet, from: comparingDate, to: comparedDate)
    }
}

