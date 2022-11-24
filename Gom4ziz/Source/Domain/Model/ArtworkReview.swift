//
//  ArtworkReview.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/20.
//

import Foundation

struct ArtworkReview: Codable, Identifiable {
    var id: String {
        return uid
    }
    let review: String
    let timeStamp: Int
    let uid: String
}

extension ArtworkReview: CustomStringConvertible {
    var description: String {
        "감상평: \(review)"
    }
}

extension ArtworkReview: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.review == rhs.review &&
        lhs.timeStamp == rhs.timeStamp &&
        lhs.uid == rhs.uid
    }
}
