//
//  UserRepository.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/11/21.
//

import Foundation

import FirebaseFirestore
import RxSwift

protocol UserRepository {
    func addUser(for user: User) -> Single<Void>
}

final class FirebaseUserRepository {
    static let shared: UserRepository = FirebaseUserRepository()
    private let db: Firestore = Firestore.firestore()
    
    private init() { }
}

// MARK: - UserRepository protocol extension
extension FirebaseUserRepository: UserRepository {
    func addUser(for user: User) -> Single<Void> {
        fetchUserRef(of: user.id)
            .rx
            .setData(user)
    }
}

// MARK: - private extension
private extension FirebaseUserRepository {
    private func fetchUserRef(of userId: String) -> DocumentReference {
        db.collection(CollectionName.user)
            .document(userId)
    }
}
