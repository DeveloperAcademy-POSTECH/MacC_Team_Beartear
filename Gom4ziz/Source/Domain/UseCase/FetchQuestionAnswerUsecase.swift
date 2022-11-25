//
//  FetchQuestionAnswerUsecase.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/11/25.
//

import UIKit

import RxSwift

protocol FetchQuestionAnswerUsecase {
    func fetchQuestionAnswerList(for userId: String, before artworkId: Int) -> Observable<[QuestionAnswer]>
}

struct RealFetchQuestionAnswerUsecase: FetchQuestionAnswerUsecase {
    
    private let questionAnswerRepository: QuestionAnswerRepository
    
    init(questionAnswerRepository: QuestionAnswerRepository = FirebaseQuestionAnswerRepository.shared) {
        self.questionAnswerRepository = questionAnswerRepository
    }
    
    func fetchQuestionAnswerList(for userId: String, before artworkId: Int) -> RxSwift.Observable<[QuestionAnswer]> {
        questionAnswerRepository.fetchQuestionAnswerList(for: userId, before: artworkId)
    }
}
