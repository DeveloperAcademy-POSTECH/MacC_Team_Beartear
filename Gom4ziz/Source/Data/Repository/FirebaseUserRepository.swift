//
//  FirebaseUserRepository.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/11/21.
//
import FirebaseFirestore
import RxSwift

protocol UserRepository {
    func addUser(for userId: String) -> Single<Void>
    func fetchUser(for userId: String) -> Observable<User>
}

final class FirebaseUserRepository {
    static let shared: UserRepository = FirebaseUserRepository()
    private let db: Firestore = Firestore.firestore()
    
    private init() { }
}

// MARK: - UserRepository protocol extension
extension FirebaseUserRepository: UserRepository {
    func addUser(for userId: String) -> Single<Void> {
        let user = User(id: userId,
                        lastArtworkId: 0,
                        firstLoginedDate: Date().yyyyMMddHHmmssFormattedInt!)
        return getUserRef(of: user.id)
            .rx
            .setData(user)
    }
    func fetchUser(for userId: String) -> Observable<User> {
        return getUserRef(of: userId)
            .rx
            .decodable(as: User.self)
    }
}

// MARK: - private extension
private extension FirebaseUserRepository {
    private func getUserRef(of userId: String) -> DocumentReference {
        db.collection(CollectionName.user)
            .document(userId)
    }
}
