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
    static let shared: UserViewModel = UserViewModel(fetchUserUsecase: RealFetchUserUsecase())
    private let fetchUserUsecase: FetchUserUsecase
    private let disposeBag: DisposeBag = .init()
    let userObservable: BehaviorRelay<Loadable<User>> = .init(value: .notRequested)
    
    init(fetchUserUsecase: FetchUserUsecase) {
        self.fetchUserUsecase = fetchUserUsecase
    }
    
    func fetchUser() {
        userObservable.accept(.isLoading(last: nil))
        fetchUserUsecase.fetchUser().subscribe { [weak self] user in
            self?.userObservable.accept(.loaded(user))
        } onError: { [weak self] error in
            self?.userObservable.accept(.failed(error))
        }
        .disposed(by: disposeBag)
    }
}
