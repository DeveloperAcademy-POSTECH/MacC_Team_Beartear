//
//  AddUserUsecase.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/12/01.
//
import UIKit

import RxSwift

protocol AddUserUsecase {
    func addUser() -> Single<User>
}

final class RealAddUserUsecase: AddUserUsecase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository = FirebaseUserRepository.shared) {
        self.userRepository = userRepository
    }
    
    func addUser() -> Single<User> {
        userRepository.addUser(for: getDeviceUUID())
    }
}

extension RealAddUserUsecase {
    private func getDeviceUUID() -> String {
#if DEBUG
        return "mock"
#else
        return UIDevice.current.identifierForVendor!.uuidString
#endif
    }
}
