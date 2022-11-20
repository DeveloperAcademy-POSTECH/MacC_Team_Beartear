//
//  ArtworkDescription.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/21.
//

import Foundation

struct ArtworkDescription: Codable, Identifiable {
    let id: Int
    let content: String
}

extension ArtworkDescription: CustomStringConvertible {
    var description: String {
        content
    }
}

extension ArtworkDescription: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id && lhs.content == rhs.content
    }
}
