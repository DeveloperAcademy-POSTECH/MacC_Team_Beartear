//
//  UserInfoRepository.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/20.
//

import Foundation

import FirebaseFirestore
import RxSwift

protocol UserInfoRepository {
    func requestUserInfo(of uid: String) -> Observable<UserInfo>
    func addUserInfo(userInfo: UserInfo) -> Single<Void>
    func deleteUserInfo(of uid: String) -> Single<Void>
}

final class FirebaseUserInfoRepository {
    static let shared: UserInfoRepository = FirebaseUserInfoRepository()
    private let db: Firestore = Firestore.firestore()
    private let userInfoIdCache: UserInfoIdCache = UserInfoIdCache()
    private var collectionName: String {
        ProcessInfo().isRunningTests ? "TestUserInfos": "UserInfos"
    }
    private init() { }
}

extension FirebaseUserInfoRepository: UserInfoRepository {

    func requestUserInfo(of uid: String) -> Observable<UserInfo> {
        getUserInfoRef(of: uid)
            .rx
            .decodable(as: UserInfo.self, source: userInfoIdCache.cached(uid) ? .cache: .server)
            .do(onNext: { [weak self] in
                self?.userInfoIdCache.cache($0.id)
            })
    }

    func addUserInfo(userInfo: UserInfo) -> Single<Void> {
        getUserInfoRef(of: userInfo.id)
            .rx
            .setData(userInfo)
    }

    func deleteUserInfo(of uid: String) -> Single<Void> {
        getUserInfoRef(of: uid)
            .rx
            .deleteDocument()
    }
}

// MARK: - Private extension
private extension FirebaseUserInfoRepository {
    func getUserInfoRef(of uid: String) -> DocumentReference {
        db.collection(collectionName).document(uid)
    }
}
