//
//  User.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/20.
//
import Foundation

struct User: Codable, Identifiable {
    let id: String
    let lastArtworkId: Int
    let firstLoginedDate: Int
}

extension User: CustomStringConvertible {
    var description: String {
        "유저 아이디: \(id) 마지막으로 감상한 작품: \(lastArtworkId) 처음 로그인한 날짜: \(firstLoginedDate)"
    }
}

extension User: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.lastArtworkId == rhs.lastArtworkId &&
        lhs.firstLoginedDate == rhs.firstLoginedDate
    }
}
