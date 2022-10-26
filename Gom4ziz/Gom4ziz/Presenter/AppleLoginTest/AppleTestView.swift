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
        var titleAttr = AttributedString.init("logout")
        let button = UIButton()
        button.configuration = configuration
        return button
    }()
    private let idLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAddSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
        
        appleLogoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appleLogoutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            appleLogoutButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            idLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            idLabel.bottomAnchor.constraint(equalTo: appleLoginButton.topAnchor, constant: -10)
        ])
    }
}
