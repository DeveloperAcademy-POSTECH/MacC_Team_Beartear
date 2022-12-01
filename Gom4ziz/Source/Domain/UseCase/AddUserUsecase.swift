//
//  AddUserUsecase.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/12/01.
//
import UIKit

import RxSwift

protocol AddUserUsecase {
    func addUser(for userId: String) -> Single<User>
}

final class RealAddUserUsecase: AddUserUsecase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository = FirebaseUserRepository.shared) {
        self.userRepository = userRepository
    }
    
    func addUser(for userId: String) -> Single<User> {
        userRepository.addUser(for: userId)
    }
}
