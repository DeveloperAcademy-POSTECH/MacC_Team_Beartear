//
//  ReviewedArtworkListCellViewModel.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/11/28.
//

import Foundation

import RxDataSources

/// ReviewedArtworkListCell 뷰를 위한 모델
struct ReviewedArtworkListCellViewModel {

    let artworkId: Int
    let numberText: String
    let artworkTitle: String
    let question: String
    let answer: String
    let artist: String
    let imageURLString: String
    
    init(artwork: Artwork, questionAnswer: QuestionAnswer) {
        self.artworkId = artwork.id
        self.artist = artwork.artist
        self.artworkTitle = artwork.title
        self.numberText = "\(artwork.id)번째 작품"
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

extension ReviewedArtworkListCellViewModel: IdentifiableType, Equatable {
    var identity: String {
        return "\(artworkId)"
    }
}

// TableView를 위한 Section
struct Section {
    var headerTitle: String = "감상기록"
    var items: [Item]
}

extension Section: AnimatableSectionModelType {
    typealias Item = ReviewedArtworkListCellViewModel
    var identity: String {
        return headerTitle
    }
    init(original: Section, items: [ReviewedArtworkListCellViewModel]) {
        self = original
        self.items = items
    }
}
