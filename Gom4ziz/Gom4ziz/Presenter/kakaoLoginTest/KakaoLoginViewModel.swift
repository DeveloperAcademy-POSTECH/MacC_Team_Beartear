//
//  KakaoLoginViewModel.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/10/26.
//

import UIKit
import RxSwift
import KakaoSDKCommon
import RxKakaoSDKCommon
import KakaoSDKAuth
import RxKakaoSDKAuth
import KakaoSDKUser
import RxKakaoSDKUser
import RxCocoa

final class KakaoLoginViewModel {
    private let disposeBag: DisposeBag = DisposeBag()
    let userInfo: PublishRelay<UserInfo> = .init()
    let kakaoLoginstatus: PublishRelay<KakaoLoginstatus> = .init()
    enum KakaoLoginstatus {
        case login
        case logout
        case unlink
    }
    init() {
    }
    func loginWithKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.rx.loginWithKakaoTalk()
                .subscribe(onNext: { (oauthToken) in
                    print("loginWithKakaoTalk() success.")
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
                    self.getUserInfo()
                    _ = oauthToken
                }, onError: {error in
                    print(error)
                })
                .disposed(by: self.disposeBag)
        }
    }
    func logout() {
        UserApi.shared.rx.logout()
            .subscribe(onCompleted: {
                print("logout() success.")
                self.userInfo.accept(UserInfo(id: UUID().uuidString, name: "로그아웃 성공", imageURL: nil))
                self.kakaoLoginstatus.accept(.logout)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    func unlink() {
        UserApi.shared.rx.unlink()
            .subscribe(onCompleted: {
                print("unlink() success.")
                self.userInfo.accept(UserInfo(id: UUID().uuidString, name: "회원 탈퇴 성공", imageURL: nil))
                self.kakaoLoginstatus.accept(.unlink)
            }, onError: {error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    func getUserInfo() {
        UserApi.shared.rx.me()
            .subscribe(onSuccess: { user in
                print("me() success.")
                if let name = user.kakaoAccount?.profile?.nickname {
                    self.userInfo.accept(UserInfo(id: UUID().uuidString, name: name, imageURL: user.kakaoAccount?.profile?.profileImageUrl))
                }
                self.kakaoLoginstatus.accept(.login)
                _ = user
            }, onFailure: {error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
