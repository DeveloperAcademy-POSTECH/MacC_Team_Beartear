//
//  KakaoLoginView.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/10/21.
//

import UIKit

final class KakaoLoginView: UIView {
    private (set) lazy var loginButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = "카카오 로그인"
        let button = UIButton(configuration: configuration)
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private (set) lazy var logoutButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = "카카오 로그아웃"
        let button = UIButton(configuration: configuration)
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private (set) lazy var unLinkButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.title = "회원 탈퇴"
        let button = UIButton(configuration: configuration)
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.text = "유저 이름 들어갈 자리"
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userImageView: UIImageView = {
        let ImageView = UIImageView()
        ImageView.backgroundColor = .red
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ImageView)
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        return ImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Don`t need to implement")
    }
}
private extension KakaoLoginView {
    func setUpViews() {
        setUpAutoLayout()
    }
    
    func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            userName.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 16),
            logoutButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            unLinkButton.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 16),
            unLinkButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: unLinkButton.bottomAnchor, constant: 16),
            userImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

#if DEBUG
import SwiftUI
struct KakaoLoginPreView: PreviewProvider {
    static var previews: some View {
        KakaoLoginView().toPreview()
    }
}
#endif
