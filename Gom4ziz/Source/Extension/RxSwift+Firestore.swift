//
//  RxSwift+Firestore.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/20.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import RxSwift

enum RxFirestoreError: Error {
    case documentIsNotExist // document 가 없는 에러
}

extension RxFirestoreError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .documentIsNotExist:
                return "데이터가 존재하지 않습니다."
        }
    }
}

extension Reactive where Base: DocumentReference {
    
    /// get document snapshot with given document reference
    /// - Parameter source: FirestoreSource
    /// - Returns: Observable of document snapshot
    func document(source: FirestoreSource = .default) -> Observable<DocumentSnapshot> {
        Observable.create { observer in
            base.getDocument(source: source) { snapshot, error in
                guard error == nil else {
                    observer.onError(error!)
                    return
                }
                guard let snapshot, snapshot.exists else {
                    observer.onError(RxFirestoreError.documentIsNotExist)
                    return
                }
                observer.onNext(snapshot)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    /// get decodable type value with given document reference
    /// - Parameters:
    ///   - as: decodable type
    ///   - source: FirestoreSource
    /// - Returns: Observable of decodable type
    func decodable<T: Decodable>(as: T.Type, source: FirestoreSource = .default) -> Observable<T> {
        document(source: source)
            .map { try $0.data(as: T.self) }
    }
    
    /// set encodable data to given document reference
    /// - Parameter data: encodable type
    /// - Returns: Single whether set data is fail or success
    func setData<T: Encodable>(_ data: T) -> Single<Void> {
        Single.create { single -> Disposable in
            do {
                try base.setData(from: data) { error in
                    if let error {
                        single(.failure(error))
                        return
                    }
                    single(.success(()))
                }
            } catch {
                single(.failure(error))
            }
            return Disposables.create()
        }
    }
    
    /// delete document
    /// - Returns: Single whether deletion is fail or success
    func deleteDocument() -> Single<Void> {
        Single.create { single -> Disposable in
            base.delete { error in
                if let error {
                    single(.failure(error))
                    return
                }
                single(.success(()))
            }
            return Disposables.create()
        }
    }
    
    func updateDocument(updateQuery: [AnyHashable: Any]) -> Single<Void> {
        Single.create { single -> Disposable in
            base.updateData(updateQuery) { error in
                if let error {
                    single(.failure(error))
                    return
                }
                single(.success(()))
            }
            
            return Disposables.create()
        }
    }
}

extension Reactive where Base: CollectionReference {
    /// get collection snapshot with given collection reference
    /// - Parameter source: FirestoreSource
    /// - Returns: Observable of collection snapshot
    func collection(source: FirestoreSource = .default) -> Observable<QuerySnapshot> {
        Observable.create { observer in
            base.getDocuments(source: source) { snapshot, error in
                guard error == nil else {
                    observer.onError(error!)
                    return
                }
                guard let snapshot else {
                    observer.onError(RxFirestoreError.documentIsNotExist)
                    return
                }
                
                observer.onNext(snapshot)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    /// get decodable type value with given document reference
    /// - Parameters:
    ///   - as: decodable type
    ///   - source: FirestoreSource
    /// - Returns: Observable of decodable type
    func decodable<T: Decodable>(as: T.Type, source: FirestoreSource = .default) -> Observable<[T]> {
        collection(source: source)
            .map { snapshot in
                var temp: [T] = []
                for document in snapshot.documents {
                    let data = try document.data(as: T.self)
                    temp.append(data)
                }
                return temp
            }
    }
}

extension Reactive where Base: Query {
    /// get documents snapshot with given document reference
    /// - Parameter source: FirestoreSource
    /// - Returns: Observable of documents snapshot
    func documents(source: FirestoreSource = .default) -> Observable<QuerySnapshot> {
        Observable.create { observer in
            base.getDocuments(source: source) { snapshot, error in
                    guard error == nil else {
                        observer.onError(error!)
                        return
                    }
                    guard let snapshot = snapshot else {
                        observer.onError(RxFirestoreError.documentIsNotExist)
                        return
                    }
                    observer.onNext(snapshot)
                    observer.onCompleted()
                }
            return Disposables.create()
        }
    }
    
    /// get decodable type value with given document reference
    /// - Parameters:
    ///   - as: decodable type
    ///   - source: FirestoreSource
    /// - Returns: Observable of decodable type
    func decodable<T: Decodable>(as: [T].Type, source: FirestoreSource = .default) -> Observable<[T]> {
        documents(source: source)
            .map { snapshot in
                var temp: [T] = []
                for document in snapshot.documents {
                    let data = try document.data(as: T.self)
                    temp.append(data)
                }
                return temp
            }
    }
}

extension Reactive where Base: Firestore {
    func runTransaction(updateBlock: @escaping (Transaction, NSErrorPointer) -> Any?) -> Single<Void> {
        Single.create { single -> Disposable in
            base.runTransaction(updateBlock) { _, error in
                if let error {
                    single(.failure(error))
                    return
                }
                single(.success(()))
            }
            
            return Disposables.create()
        }
    }
}
