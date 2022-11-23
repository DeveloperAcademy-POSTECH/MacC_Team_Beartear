//
//  FetchUserUsecase.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/11/23.
//

import UIKit

import RxSwift

protocol FetchUserUsecase {
    func fetchUser() -> Observable<User>
}

struct RealFetchUserUsecase: FetchUserUsecase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository = FirebaseUserRepository.shared) {
        self.userRepository = userRepository
    }
    
    func fetchUser() -> Observable<User> {
        userRepository.fetchUser(for: getDeviceUUID())
    }
}

extension RealFetchUserUsecase {
    private func getDeviceUUID() -> String {
#if DEBUG
        return "mock"
#else
        return UIDevice.current.identifierForVendor!.uuidString
#endif
    }
}
