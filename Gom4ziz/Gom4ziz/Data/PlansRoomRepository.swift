//
//  PlansRoomRepository.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/10/23.
//

import Foundation
import FirebaseFirestore
import RxSwift

protocol PlansRoomRepository {
    func requestPlansRoom(of roomId: String) -> Observable<PlansRoom>
    func fetchPlansRoomList(for uid: String) -> Observable<[PlansRoom]>
    func addPlansRoom(for plansRoom: PlansRoom) -> Single<Void>
    func updatePlansRoom(of roomId: String, for plansRoom: PlansRoom) -> Single<Void>
    func deletePlansRoom(of roomId: String) -> Single<Void>
}

final class FirebasePlansRoomRepository {
    static let shared: PlansRoomRepository = FirebasePlansRoomRepository()
    private let db: Firestore = Firestore.firestore()
    private let userInfoIdCache: UserInfoIdCache = UserInfoIdCache()
    private let plansRoomIdCache: PlansRoomIdCache = PlansRoomIdCache()
    private var plansRoomCollectionName: String {
        ProcessInfo().isRunningTests ? "TestPlansRooms" : "PlansRooms"
    }
    private init() { }
}

extension FirebasePlansRoomRepository: PlansRoomRepository {
    func fetchPlansRoomList(for uid: String) -> Observable<[PlansRoom]> {
        Observable<[PlansRoom]>.create { [self] observer in
            fetchPlansRoomsRef()
                .getDocuments { snapshot, error in
                    do {
                        guard error == nil else {
                            observer.onError(error!)
                            return
                        }
                        guard let snapshot = snapshot else {
                            observer.onError(RxFirestoreError.documentIsNotExist)
                            return
                        }
                        var temp: [PlansRoom] = []
                        for document in snapshot.documents {
                            let data = try document.data(as: PlansRoom.self)
                            temp.append(data)
                        }
                        observer.onNext(temp)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
    func requestPlansRoom(of roomId: String) -> Observable<PlansRoom> {
        fetchPlansRoomRef(of: roomId)
            .rx
            .decodable(as: PlansRoom.self, source: plansRoomIdCache.cached(roomId) ? .cache : .server)
            .do(onNext: { [weak self] in
                self?.plansRoomIdCache.cache($0.id)
            })
    }
    func addPlansRoom(for plansRoom: PlansRoom) -> Single<Void> {
        fetchPlansRoomRef(of: plansRoom.id)
            .rx
            .setData(plansRoom)
    }
    func updatePlansRoom(of roomId: String, for plansRoom: PlansRoom) -> Single<Void> {
        fetchPlansRoomRef(of: roomId)
            .rx
            .setData(plansRoom)
    }
    func deletePlansRoom(of roomId: String) -> Single<Void> {
        fetchPlansRoomRef(of: roomId)
            .rx
            .deleteDocument()
    }
}

// MARK: - Private extension
private extension FirebasePlansRoomRepository {
    func fetchPlansRoomRef(of roomId: String) -> DocumentReference {
        db.collection(plansRoomCollectionName)
            .document(roomId)
    }
    func fetchPlansRoomsRef() -> CollectionReference {
        db.collection(plansRoomCollectionName)
    }
}
