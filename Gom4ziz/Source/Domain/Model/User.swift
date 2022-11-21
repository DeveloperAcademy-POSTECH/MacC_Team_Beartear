//
//  User.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/20.
//
import UIKit

struct User: Codable, Identifiable {
    let id: String
    let lastArtworkId: Int
    
    init(lastArtworkId: Int) {
        self.id = User.getDeviceUUID()
        self.lastArtworkId = lastArtworkId
    }
    
    init(id: String, lastArtworkId: Int) {
        self.id = id
        self.lastArtworkId = lastArtworkId
    }
    
    static func getDeviceUUID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
}

extension User: CustomStringConvertible {
    var description: String {
        "유저 아이디: \(id) 마지막으로 감상한 작품: \(lastArtworkId)"
    }
}

extension User: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id && lhs.lastArtworkId == rhs.lastArtworkId
    }
}


