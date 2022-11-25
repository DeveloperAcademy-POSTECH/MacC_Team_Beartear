//
//  FirebaseQuestionAnswerRepository.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/11/24.
//

import Foundation

import FirebaseFirestore
import RxSwift

protocol QuestionAnswerRepository {
    func fetchQuestionAnswerList(for userId: String, before artworkId: Int) -> Observable<[QuestionAnswer]>
}

struct FirebaseQuestionAnswerRepository {
    static let shared = FirebaseQuestionAnswerRepository()
    private let db: Firestore = Firestore.firestore()
}

// MARK: - QuestionAnswerRepository protocol extension
extension FirebaseQuestionAnswerRepository: QuestionAnswerRepository {
    func fetchQuestionAnswerList(for userId: String, before artworkId: Int) -> Observable<[QuestionAnswer]> {
        var questionAnswerObservableList: [Observable<QuestionAnswer>] = []
        for i in 1...artworkId {
            questionAnswerObservableList.append(getQuestionAnswerListRef(for: userId, before: i)
                .rx
                .decodable(as: QuestionAnswer.self))
        }
        return Observable.zip(questionAnswerObservableList) { $0 }
    }
}

// MARK: - private extension
extension FirebaseQuestionAnswerRepository {
    private func getQuestionAnswerListRef(for userId: String, before artworkId: Int) -> DocumentReference {
        db
            .collection(CollectionName.artwork)
            .document(String(artworkId))
            .collection(CollectionName.questionAnswer)
            .document(String(userId))
    }
}

