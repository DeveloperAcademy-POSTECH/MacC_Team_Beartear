//
//  PromiseRoom.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/20.
//

import Foundation

/// 약속 방을 나타내는 struct
struct PlansRoom: Identifiable, Hashable, Codable {
    let id: String // Room 고유의 아이디
    let name: String // Room의 타이틀
    let date: Date? // 약속 일자
    let place: String? // 약속 장소
    let isEnd: Bool // 투표 마감 여부
    let currentMemberIds: [String] // 현재 방에 참여한 유저의 id 배열
}

// MARK: - toString
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
