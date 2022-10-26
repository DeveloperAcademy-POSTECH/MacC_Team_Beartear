//
//  AppleTestViewController.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/10/26.
//

import Foundation
import UIKit

final class AppleTestViewController: UIViewController {

    private lazy var appleLoginManager: AppleLoginManager = {
        let manager = AppleLoginManager(vc: self)
        return manager
    }()
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
    }

    // MARK: - @objc function

    @objc private func tapAppleLoginButton() {
        appleLoginManager.startSignInWithAppleFlow()
    }
}

extension AppleTestViewController: AppleLoginManagerDelegate {
    func appleLoginSuccess() {
        print("success")
    }

    func appleLoginFail() {
        print("fail")
    }
}
