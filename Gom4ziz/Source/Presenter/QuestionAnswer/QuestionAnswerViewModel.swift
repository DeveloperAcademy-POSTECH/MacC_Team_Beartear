//
//  QuestionAnswerViewModel.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/23.
//

import RxSwift
import RxRelay

final class QuestionAnswerViewModel {
    let artwork: Artwork
    var myAnswer: String

    init(of artwork: Artwork) {
        self.artwork = artwork
        self.myAnswer = ""
    }

}
