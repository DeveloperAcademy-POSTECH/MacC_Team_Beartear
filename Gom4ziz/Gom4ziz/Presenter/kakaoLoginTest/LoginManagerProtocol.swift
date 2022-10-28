//
//  LoginManagerProtocol.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/10/27.
//

import Foundation
import RxRelay

enum Loginstatus {
    case login
    case logout
    case unlink
}

protocol LoginManagerProtocol {
    func login()
    func logout()
    func unlink()
    func getUserInfo()
    var userInfo: PublishRelay<UserInfo> { get }
    var loginstatus: PublishRelay<Loginstatus> { get }
}
