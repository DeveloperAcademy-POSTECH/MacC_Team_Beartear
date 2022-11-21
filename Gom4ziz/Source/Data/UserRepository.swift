//
//  UserRepository.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/11/21.
//
import FirebaseFirestore
import RxSwift

protocol UserRepository {
    func addUser(for userId: String) -> Single<Void>
}

final class FirebaseUserRepository {
    static let shared: UserRepository = FirebaseUserRepository()
    private let db: Firestore = Firestore.firestore()
    
    private init() { }
}

// MARK: - UserRepository protocol extension
extension FirebaseUserRepository: UserRepository {
    func addUser(for userId: String) -> Single<Void> {
        let user = User(id: userId, lastArtworkId: 0)
        return getUserRef(of: user.id)
            .rx
            .setData(user)
    }
}

// MARK: - private extension
private extension FirebaseUserRepository {
    private func getUserRef(of userId: String) -> DocumentReference {
        db.collection(CollectionName.user)
            .document(userId)
    }
    #warning("후에 UseCase쪽으로 해당 함수 이동시키기")
//    private func getDeviceUUID() -> String {
//        return UIDevice.current.identifierForVendor!.uuidString
//    }
}
