//
//  UserViewModel.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/11/23.
//

import Foundation

import Loadable
import RxSwiftLoadable
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
        fetchUserUsecase
            .fetchUser()
            .catch { error in
                if case RxFirestoreError.documentIsNotExist = error {
                    return Observable.error(UserRequestError.notRegisteredUser)
                } else {
                    return Observable.error(error)
                }
            }
            .bindLoadable(to: userObservable)
            .disposed(by: disposeBag)
    }
    
    func addUser(for userId: String) {
        userObservable.accept(.isLoading(last: nil))
        addUserUsecase.addUser(for: userId)
            .bindLoadable(to: userObservable)
            .disposed(by: disposeBag)
    }
}
