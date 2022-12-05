//
//  UserViewModel.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/11/23.
//

import Foundation

import RxCocoa
import RxSwift

final class UserViewModel {
    static let shared: UserViewModel = UserViewModel(fetchUserUsecase: RealFetchUserUsecase(), addUserUsecase: RealAddUserUsecase())
    private let fetchUserUsecase: FetchUserUsecase
    private let addUserUsecase: AddUserUsecase
    private let disposeBag: DisposeBag = .init()
    let userObservable: BehaviorRelay<Loadable<User>> = .init(value: .notRequested)
    var user: User? {
        userObservable.value.value
    }
    
    init(
        fetchUserUsecase: FetchUserUsecase = RealFetchUserUsecase(),
        addUserUsecase: AddUserUsecase = RealAddUserUsecase()
    ) {
        self.fetchUserUsecase = fetchUserUsecase
        self.addUserUsecase = addUserUsecase
    }

#if DEBUG
    init() {
        self.fetchUserUsecase = RealFetchUserUsecase()
        self.addUserUsecase = RealAddUserUsecase()
        self.userObservable.accept(.loaded(User.mockData))
    }
    #endif
    
    func fetchUser() {
        userObservable.accept(.isLoading(last: nil))
        fetchUserUsecase.fetchUser().subscribe { [weak self] user in
            self?.userObservable.accept(.loaded(user))
        } onError: { [weak self] error in
            if case RxFirestoreError.documentIsNotExist = error {
                self?.userObservable.accept(.failed(UserRequestError.notRegisteredUser))
            } else {
                self?.userObservable.accept(.failed(error))
            }
        }
        .disposed(by: disposeBag)
    }
    
    func addUser(for userId: String) {
        userObservable.accept(.isLoading(last: nil))
        addUserUsecase.addUser(for: userId)
            .subscribe(onSuccess: { [weak self] user in
                self?.userObservable.accept(.loaded(user))
            },
                       onFailure: { [weak self] error in
                self?.userObservable.accept(.failed(error))
            })
            .disposed(by: disposeBag)
    }
}
