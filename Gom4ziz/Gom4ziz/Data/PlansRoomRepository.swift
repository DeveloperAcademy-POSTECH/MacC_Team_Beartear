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
    func fetchPlansRoomList(for uid: String) -> Observable<[PlansRoom]>
    func addPlansRoom(for plansRoom: PlansRoom) -> Single<Void>
    func updatePlansRoom(for plansRoom: PlansRoom) -> Single<Void>
    func deletePlansRoom(of roomId: String) -> Single<Void>
    func joinPlansRoom(uid: String, plansRoom: PlansRoom) -> Single<Void>
}

final class FirebasePlansRoomRepository {
    static let shared: PlansRoomRepository = FirebasePlansRoomRepository()
    private let db: Firestore = Firestore.firestore()
    private var plansRoomCollectionName: String {
        ProcessInfo().isRunningTests ? "TestPlansRooms" : "PlansRooms"
    }
    private init() { }
}

extension FirebasePlansRoomRepository: PlansRoomRepository {

    func joinPlansRoom(uid: String, plansRoom: PlansRoom) -> Single<Void> {
        fetchPlansRoomRef(of: plansRoom.id)
            .rx
            .updateDocument(updateQuery: [
                "currentMemberIds": FieldValue.arrayUnion([uid])
            ])
    }

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

    func addPlansRoom(for plansRoom: PlansRoom) -> Single<Void> {
        fetchPlansRoomRef(of: plansRoom.id)
            .rx
            .setData(plansRoom)
    }

    func updatePlansRoom(for plansRoom: PlansRoom) -> Single<Void> {
        fetchPlansRoomRef(of: plansRoom.id)
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
