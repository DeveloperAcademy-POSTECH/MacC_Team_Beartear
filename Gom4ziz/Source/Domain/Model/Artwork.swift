//
//  Artwork.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/20.
//

import Foundation

struct Artwork: Codable, Identifiable {
    let id: Int
    let imageUrl: String
    let question: String
    let title: String
    let artist: String
}

extension Artwork: CustomStringConvertible {
    var description: String {
        "작품 이름: \(title) 작가: \(artist) 질문: \(question)"
    }
}

extension Artwork: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.imageUrl == rhs.imageUrl &&
        lhs.question == rhs.question &&
        lhs.title == rhs.title &&
        lhs.artist == rhs.artist
    }
}
