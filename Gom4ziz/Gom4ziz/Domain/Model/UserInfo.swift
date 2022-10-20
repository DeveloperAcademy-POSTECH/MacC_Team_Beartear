//
//  UserInfo.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/20.
//

import Foundation

struct UserInfo: Identifiable, Codable, Hashable {
    let id: String
    let name: String
}

extension UserInfo: Equatable {
    static func == (lhs: UserInfo, rhs: UserInfo) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }
}

extension UserInfo: CustomStringConvertible {
    var description: String {
        "유저 아이디: \(id) 유저 이름: \(name)"
    }
}
