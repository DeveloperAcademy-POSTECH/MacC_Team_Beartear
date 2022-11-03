//
//  AppleTestView.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/10/26.
//
import AuthenticationServices
import UIKit

final class AppleTestView: UIView {

    private (set) lazy var appleLoginButton = ASAuthorizationAppleIDButton()
    private (set) lazy var appleLogoutButton: UIButton = {
        var configuration: UIButton.Configuration = . filled()
        let button = UIButton()
        configuration.title = "로그아웃"
        button.configuration = configuration
        return button
    }()
    private (set) lazy var appleWithdrawalButton: UIButton = {
        var configuration: UIButton.Configuration = . filled()
        let button = UIButton()
        configuration.title = "탈퇴"
        button.configuration = configuration
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configureAddSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("No need to implement")
    }

    // MARK: - addSubview

    private func configureAddSubviews() {
        self.addSubview(appleLoginButton)
        self.addSubview(appleLogoutButton)
        self.addSubview(appleWithdrawalButton)
    }

    private func configureConstraints() {
        appleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appleLoginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            appleLoginButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        appleLogoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appleLogoutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            appleLogoutButton.topAnchor.constraint(equalTo: appleLoginButton.bottomAnchor, constant: 30)
        ])

        appleWithdrawalButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appleWithdrawalButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            appleWithdrawalButton.topAnchor.constraint(equalTo: appleLogoutButton.bottomAnchor, constant: 30)
        ])
    }
}
