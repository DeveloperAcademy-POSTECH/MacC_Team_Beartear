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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        let tempContent = try container.decode(String.self, forKey: .content)
        self.content = tempContent.convertNewLine
    }
    
    init(id: Int, content: String) {
        self.id = id
        self.content = content
    }
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
