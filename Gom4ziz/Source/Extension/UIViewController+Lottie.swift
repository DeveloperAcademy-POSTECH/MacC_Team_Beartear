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
        guard let window = view.window else { return }
        let lottieLoadingView: LottieAnimationView = LottieAnimationView(name: "spinner")
        lottieLoadingView.loopMode = .loop
        lottieLoadingView.backgroundColor = .black.withAlphaComponent(0.5)
        lottieLoadingView.tag = 1004
        lottieLoadingView.frame = window.bounds
        window.addSubview(lottieLoadingView)
        lottieLoadingView.play()
    }

    func hideLottieLoadingView() {
        guard let window = view.window else { return }
        window.viewWithTag(1004)?.removeFromSuperview()
    }

}
