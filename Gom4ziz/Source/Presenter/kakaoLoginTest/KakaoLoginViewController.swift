//
//  KakaoLoginViewController.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/10/24.
//
import UIKit

import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import RxCocoa
import RxSwift
import RxKakaoSDKAuth
import RxKakaoSDKCommon
import RxKakaoSDKUser

final class KakaoLoginViewController: UIViewController {
    private lazy var testView: KakaoLoginView = KakaoLoginView()
    private let disposeBag: DisposeBag = DisposeBag()
    private let viewmodel = LoginViewModel(loginManager: KakaoLoginManager())
    override func viewDidLoad() {
        super.viewDidLoad()
        isTokenVailed()
        setObserver()
    }
    override func loadView() {
        view = testView
    }
}

private extension KakaoLoginViewController {
    
    func isTokenVailed() {
        if AuthApi.hasToken() {
            UserApi.shared.rx.accessTokenInfo()
                .subscribe(onSuccess: { [self] _ in
                    print("토큰 유효성 체크 성공(필요 시 토큰 갱신됨)")
                    viewmodel.getUserInfo()
                }, onFailure: {error in
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true {
                        print("로그인 필요")
                    } else {
                        print("기타 에러")
                    }
                })
                .disposed(by: disposeBag)
        } else {
            print("로그인 필요")
        }
    }
    
    func setObserver() {
        testView.loginButton.rx.tap
            .bind { [self] _ in
                viewmodel.loginWithKakao()
            }
            .disposed(by: disposeBag)
        
        testView.logoutButton.rx.tap
            .bind { [self] _ in
                viewmodel.logout()
            }
            .disposed(by: disposeBag)
        
        testView.unLinkButton.rx.tap
            .bind { [self] _ in
                viewmodel.withDrawal()
            }
            .disposed(by: disposeBag)
        
        viewmodel.loginManager.userInfo
            .map(\.name)
            .bind(to: testView.userName.rx.text)
            .disposed(by: disposeBag)
        
        viewmodel.loginManager.userInfo
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .compactMap(\.imageURL)
            .compactMap { try Data(contentsOf: $0) }
            .compactMap { UIImage(data: $0) }
            .observe(on: MainScheduler.instance)
            .bind(to: testView.userImageView.rx.image)
            .disposed(by: disposeBag)
        
        viewmodel.loginManager.loginstatus
            .subscribe(onNext: { [self] status in
                switch status {
                    case .logout:
                        testView.loginButton.isHidden = false
                        testView.userImageView.isHidden = true
                        testView.logoutButton.isHidden = true
                        testView.unLinkButton.isHidden = true
                    case .withDrawal:
                        testView.loginButton.isHidden = false
                        testView.userImageView.isHidden = true
                        testView.logoutButton.isHidden = true
                        testView.unLinkButton.isHidden = true
                    case .login:
                        testView.loginButton.isHidden = true
                        testView.userImageView.isHidden = false
                        testView.logoutButton.isHidden = false
                        testView.unLinkButton.isHidden = false
                }
            })
            .disposed(by: disposeBag)
    }
}

#if DEBUG
import SwiftUI
import KakaoSDKUser
struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        KakaoLoginViewController().toPreview()
    }
}
#endif
