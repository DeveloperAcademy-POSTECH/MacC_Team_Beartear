//
//  SceneDelegate.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/19.
//

import UIKit

import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private let disposeBag: DisposeBag = .init()
    private let userViewModel: UserViewModel = UserViewModel.shared

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene  else {
            return
        }
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        // 테스트를 위해서 루트 뷰컨트롤러를 변경할 수 있습니다.
        testToastMessage()
        changeStatusBarBgColor(bgColor: .white)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}

extension SceneDelegate {
    
    /// 윈도우의 루트 뷰컨을 바꾸는 함수
    /// - Parameter controller: 바꿀 뷰컨트롤러
    func changeRootViewController(_ controller: UIViewController) {
        window?.rootViewController = controller
    }
    
    /// user 상태에 따라 윈도우의 루트 뷰컨을 바꾸는 함수
    func changeRootViewControllerBasedOnUserStatus() {
        userViewModel.userObservable
            .subscribe(
                onNext: { [weak self] in
                    guard let self else { return }
                    switch $0 {
                    case .loaded:
                        self.changeRootViewController(MainViewController())
                        print("loaded")
                    case .isLoading:
                        // loading 화면
                        print("loading")
                    case .failed(let error):
                        if let error = error as? UserRequestError, error == .notRegisteredUser {
                            self.changeRootViewController(OnBoardingViewController())
                        } else {
                            // error 화면
                        }
                    case .notRequested:
                        // loading 화면
                        print("loading")
                    }
                })
            .disposed(by: disposeBag)
        userViewModel.fetchUser()
    }

    func changeStatusBarBgColor(bgColor: UIColor?) {
        let statusBarManager = window?.windowScene?.statusBarManager
        let statusBarView = UIView(frame: statusBarManager?.statusBarFrame ?? .zero)
        statusBarView.backgroundColor = bgColor
        window?.addSubview(statusBarView)
    }
}
