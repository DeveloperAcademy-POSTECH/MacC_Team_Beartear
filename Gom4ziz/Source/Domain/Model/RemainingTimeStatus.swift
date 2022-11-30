//
//  File.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/30.
//

import Foundation

enum RemainingTimeStatus {
    case moreThanOneDay(day: Int)
    case lessThanDayMoreThanHour(hour: Int)
    case lessThanOneHour(minute: Int)
}

extension RemainingTimeStatus {
    
    var bakingStatusString: String {
        switch self {
        case .moreThanOneDay:
            return "반죽 만드는 중"
        case .lessThanDayMoreThanHour, .lessThanOneHour:
            return "크림 만드는 중"
        }
    }
    
    var remainingTimeToString: String {
        switch self {
        case .moreThanOneDay(let day):
            return "\(day)일"
        case .lessThanDayMoreThanHour(let hour):
            return "\(hour)시간"
        case .lessThanOneHour(let minute):
            return "\(minute)분"
        }
    }
}
