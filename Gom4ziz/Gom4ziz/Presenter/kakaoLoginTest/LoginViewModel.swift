//
//  LoginViewModel.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/10/26.
//

import UIKit

final class LoginViewModel {
    let loginManager: LoginManagerProtocol
    
    init(loginManager: LoginManagerProtocol) {
        self.loginManager = loginManager
    }
    
    func loginWithKakao() {
        loginManager.login()
    }
    
    func logout() {
        loginManager.logout()
    }
    
    func withDrawal() {
        loginManager.withDrawal()
    }
    
    func getUserInfo() {
        loginManager.getUserInfo()
    }
}
