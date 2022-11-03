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
    let imageURL: URL?
    init(id: String, name: String, imageURL: URL? = nil) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
    }
}

extension UserInfo: Equatable {
    static func == (lhs: UserInfo, rhs: UserInfo) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name && lhs.imageURL == rhs.imageURL
    }
}

extension UserInfo: CustomStringConvertible {
    var description: String {
        "유저 아이디: \(id) 유저 이름: \(name) 이미지 url: \(String(describing: imageURL))"
    }
}
