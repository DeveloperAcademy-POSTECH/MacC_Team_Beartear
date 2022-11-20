//
//  Highlight.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/21.
//

import Foundation

struct Highlight: Codable {
    let start: Int
    let end: Int
}

extension Highlight: CustomStringConvertible {
    var description: String {
        "하이라이트 시작 인덱스: \(start) 마지막 인덱스: \(end)"
    }
}

extension Highlight: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.start == rhs.start && lhs.end == rhs.end
    }
}
