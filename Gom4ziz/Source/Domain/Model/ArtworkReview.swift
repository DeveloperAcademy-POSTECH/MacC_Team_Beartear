//
//  ArtworkReview.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/20.
//

import Foundation

struct ArtworkReview: Codable, Identifiable {
    let id: String
    let questionAnswer: String
    let review: String
    let timeStamp: Date
    let uid: String
}

extension ArtworkReview: CustomStringConvertible {
    var description: String {
        "질문답변: \(questionAnswer) 감상평: \(review)"
    }
}

extension ArtworkReview: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
        lhs.questionAnswer == rhs.questionAnswer &&
        lhs.review == rhs.review &&
        lhs.timeStamp == rhs.timeStamp &&
        lhs.uid == rhs.uid
    }
}
