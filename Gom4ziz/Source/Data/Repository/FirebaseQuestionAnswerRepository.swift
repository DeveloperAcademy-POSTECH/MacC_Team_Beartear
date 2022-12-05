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

        guard artworkId > 0 else {
            return Observable.just([])
        }

        let observables = (1...artworkId).map { self.getQuestionAnswerRef(for: userId, before: $0).rx.decodable(as: QuestionAnswer.self) }

        return Observable.zip(observables)
    }
}

// MARK: - private extension
extension FirebaseQuestionAnswerRepository {
    private func getQuestionAnswerRef(for userId: String, before artworkId: Int) -> DocumentReference {
        db
            .collection(CollectionName.artwork)
            .document(String(artworkId))
            .collection(CollectionName.questionAnswer)
            .document(String(userId))
    }
}

