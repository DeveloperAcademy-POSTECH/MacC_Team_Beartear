//
//  PromiseRoom.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/20.
//

import Foundation

struct PlansRoom: Identifiable, Hashable, Codable {
    let id: String
    let name: String
    let date: Date?
    let place: String?
    let isEnd: Bool
}

extension PlansRoom: CustomStringConvertible {
    var description: String {
        "약속방 이름: \(name) 약속 날짜: \(date?.description ?? "날짜 없음") 약속 장소: \(place ?? "장소 없음") 마감여부: \(isEnd)"
    }
}

extension PlansRoom: Equatable {
    static func == (lhs: PlansRoom, rhs: PlansRoom) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.date == rhs.date && lhs.place == rhs.place && lhs.isEnd == rhs.isEnd
    }
}
