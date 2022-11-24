//
//  QuestionAnswer.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/11/24.
//

import Foundation

struct QuestionAnswer: Codable, Identifiable {
    var id: String
    let questionAnswer: String
    let timeStamp: Int
    let uid: String
}

extension QuestionAnswer: CustomStringConvertible {
    var description: String {
        "질문답변: \(questionAnswer)"
    }
}

extension QuestionAnswer: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.questionAnswer == rhs.questionAnswer &&
        lhs.timeStamp == rhs.timeStamp &&
        lhs.uid == rhs.uid
    }
}

