//
//  AppleTestViewController.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/10/26.
//

import UIKit

import FirebaseAuth

final class AppleTestViewController: UIViewController {

    private lazy var appleLoginManager = AppleLoginManager(presentingViewController: self)
    private let appleTestView = AppleTestView()

    override func viewDidLoad() {
        super.viewDidLoad()
        appleLoginManager.delegate = self
        bindingView()
    }

    override func loadView() {
        self.view = appleTestView
    }

    private func bindingView() {
        appleTestView.appleLoginButton.addTarget(self, action: #selector(tapAppleLoginButton), for: .touchUpInside)
        appleTestView.appleLogoutButton.addTarget(self, action: #selector(tapAppleLogoutButton), for: .touchUpInside)
        appleTestView.appleWithdrawalButton.addTarget(self, action: #selector(tapAppleWithdrawalButton), for: .touchUpInside)
    }

    // MARK: - @objc function

    @objc private func tapAppleLoginButton() {
        appleLoginManager.startSignInWithAppleFlow()
    }

    @objc private func tapAppleLogoutButton() {
        appleLoginManager.signOut()
    }

    @objc private func tapAppleWithdrawalButton() {
        appleLoginManager.withDrawal()
    }
}

extension AppleTestViewController: AppleLoginManagerDelegate {
    func appleLoginSuccess(authResult: AuthDataResult?) {
        // TODO: keychain 연동
        print("success")
    }

    func appleLoginFail() {
        print("fail")
    }
}
