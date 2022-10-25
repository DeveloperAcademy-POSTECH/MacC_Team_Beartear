//
//  KakaoLoginViewController.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/10/24.
//

import UIKit
import RxSwift
import KakaoSDKCommon
import RxKakaoSDKCommon
import KakaoSDKAuth
import RxKakaoSDKAuth
import KakaoSDKUser
import RxKakaoSDKUser

final class KakaoLoginViewController: UIViewController {
    private lazy var testView: KakaoLoginView = KakaoLoginView()
    private let disposeBag: DisposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        isTokenVailed()
        setObserver()
    }
    override func loadView() {
        self.view = testView
    }
}

private extension KakaoLoginViewController {
    private func isTokenVailed() {
        if AuthApi.hasToken() {
            UserApi.shared.rx.accessTokenInfo()
                .subscribe(onSuccess: { (_) in
                    print("토큰 유효성 체크 성공(필요 시 토큰 갱신됨)")
                    self.getUserInfo()
                }, onFailure: {error in
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true {
                        print("로그인 필요")
                    } else {
                        print("기타 에러")
                    }
                })
                .disposed(by: self.disposeBag)
        } else {
            print("로그인 필요")
        }
    }
    func setObserver() {
        testView.loginButton.rx.tap
            .bind {
                self.loginWithKakao()
            }
            .disposed(by: disposeBag)
        testView.logoutButton.rx.tap
            .bind {
                self.logout()
            }
            .disposed(by: disposeBag)
        testView.unLinkButton.rx.tap
            .bind {
                self.unlink()
            }
            .disposed(by: disposeBag)
    }
    private func loginWithKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.rx.loginWithKakaoTalk()
                .subscribe(onNext: { (oauthToken) in
                    print("loginWithKakaoTalk() success.")
                    // do something
                    self.getUserInfo()
                    _ = oauthToken
                }, onError: {error in
                    print(error)
                })
                .disposed(by: self.disposeBag)
        } else {
            UserApi.shared.rx.loginWithKakaoAccount()
                .subscribe(onNext: { (oauthToken) in
                    print("loginWithKakaoAccount() success.")
                    // do something
                    self.getUserInfo()
                    _ = oauthToken
                }, onError: {error in
                    print(error)
                })
                .disposed(by: self.disposeBag)
        }
    }
    private func logout() {
        UserApi.shared.rx.logout()
            .subscribe(onCompleted: {
                print("logout() success.")
                self.testView.userName.text = "로그아웃 성공"
                self.testView.userImageView.isHidden = true
                self.testView.loginButton.isHidden = false
                self.testView.logoutButton.isHidden = true
                self.testView.unLinkButton.isHidden = true
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    private func unlink() {
        UserApi.shared.rx.unlink()
            .subscribe(onCompleted: {
                print("unlink() success.")
                self.testView.userName.text = "회원 탈퇴 성공"
                self.testView.userImageView.isHidden = true
                self.testView.loginButton.isHidden = false
                self.testView.logoutButton.isHidden = true
                self.testView.unLinkButton.isHidden = true
            }, onError: {error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    private func getUserInfo() {
        UserApi.shared.rx.me()
            .subscribe(onSuccess: { user in
                print("me() success.")
                // do something
                self.testView.loginButton.isHidden = true
                self.testView.logoutButton.isHidden = false
                self.testView.unLinkButton.isHidden = false
                self.testView.userName.text = user.kakaoAccount?.profile?.nickname
                self.testView.userImageView.isHidden = false
                if let url = user.kakaoAccount?.profile?.profileImageUrl,
                   let data = try? Data(contentsOf: url) {
                    self.testView.userImageView.image = UIImage(data: data)
                }
                _ = user
            }, onFailure: {error in
                print(error)
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
