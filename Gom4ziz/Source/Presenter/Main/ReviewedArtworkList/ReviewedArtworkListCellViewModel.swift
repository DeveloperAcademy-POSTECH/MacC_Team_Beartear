//
//  ReviewedArtworkListCellViewModel.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/11/28.
//

import Foundation

/// ReviewedArtworkListCell 뷰를 위한 모델
struct ReviewedArtworkListCellViewModel {
    let artworkId: Int
    let numberText: String
    let question: String
    let answer: String
    let imageURLString: String
    
    init(artwork: Artwork, questionAnswer: QuestionAnswer) {
        self.artworkId = artwork.id
        self.numberText = "\(artwork.id)번째 티라미술"
        self.question = artwork.question
        self.answer = questionAnswer.questionAnswer
        self.imageURLString = artwork.imageUrl
    }
}

extension ReviewedArtworkListCellViewModel: CustomStringConvertible {
    var description: String {
        "\(numberText), 질문 : \(question), 답변: \(answer)"
    }
}
