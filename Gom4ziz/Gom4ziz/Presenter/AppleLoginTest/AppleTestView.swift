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
    private let idLabel = UILabel()

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
    }

    private func configureConstraints() {
        appleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appleLoginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            appleLoginButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
