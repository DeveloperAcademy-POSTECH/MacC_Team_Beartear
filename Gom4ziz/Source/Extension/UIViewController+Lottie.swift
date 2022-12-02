//
//  UIViewController+Lottie.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/30.
//

import UIKit

import Lottie

extension UIViewController {

    func showLottieLoadingView() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first else { return }
        
        let lottieLoadingView: LottieAnimationView = LottieAnimationView(name: "spinner")
        lottieLoadingView.loopMode = .loop
        lottieLoadingView.backgroundColor = .black.withAlphaComponent(0.5)
        lottieLoadingView.tag = ViewTag.lottieView.rawValue
        lottieLoadingView.frame = window.bounds
        window.addSubview(lottieLoadingView)
        lottieLoadingView.play()
    }

    func hideLottieLoadingView() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first else { return }
        window.viewWithTag(ViewTag.lottieView.rawValue)?.removeFromSuperview()
    }

}
