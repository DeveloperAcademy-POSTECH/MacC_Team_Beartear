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
    private let viewmodel = KakaoLoginViewModel()
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
                    self.viewmodel.getUserInfo()
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
                self.viewmodel.loginWithKakao()
            }
            .disposed(by: disposeBag)
        testView.logoutButton.rx.tap
            .bind {
                self.viewmodel.logout()
            }
            .disposed(by: disposeBag)
        testView.unLinkButton.rx.tap
            .bind {
                self.viewmodel.unlink()
            }
            .disposed(by: disposeBag)
        viewmodel.userInfo
            .map(\.name)
            .bind(to: testView.userName.rx.text)
            .disposed(by: disposeBag)
        viewmodel.userInfo
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .compactMap(\.imageURL)
            .compactMap { try Data(contentsOf: $0) }
            .compactMap { UIImage(data: $0) }
            .observe(on: MainScheduler.instance)
            .bind(to: self.testView.userImageView.rx.image)
            .disposed(by: disposeBag)
        viewmodel.kakaoLoginstatus
            .subscribe(onNext: { status in
                switch status {
                case .logout:
                        self.testView.loginButton.isHidden = false
                        self.testView.userImageView.isHidden = true
                        self.testView.logoutButton.isHidden = true
                        self.testView.unLinkButton.isHidden = true
                case .unlink:
                        self.testView.loginButton.isHidden = false
                        self.testView.userImageView.isHidden = true
                        self.testView.logoutButton.isHidden = true
                        self.testView.unLinkButton.isHidden = true
                case .login:
                        self.testView.loginButton.isHidden = true
                        self.testView.userImageView.isHidden = false
                        self.testView.logoutButton.isHidden = false
                        self.testView.unLinkButton.isHidden = false
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
