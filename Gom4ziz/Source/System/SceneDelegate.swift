//
//  SceneDelegate.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/19.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene  else {
            return
        }
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()

        // 테스트를 위해서 루트 뷰컨트롤러를 변경할 수 있습니다.
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        print(URLContexts)
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
}
