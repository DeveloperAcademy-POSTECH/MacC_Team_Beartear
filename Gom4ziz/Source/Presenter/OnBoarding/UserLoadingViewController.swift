//
//  UserLoadingViewController.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/12/02.
//

import UIKit

import Lottie

final class UserLoadingViewController: UIViewController {
    
    private let loadingView: LottieAnimationView = .init(name: "tiramisulLogo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setUpUI()
    }
}

private extension UserLoadingViewController {
    
    func addSubviews() {
        view.addSubview(loadingView)
    }
    
    func setUpUI() {
        loadingView.backgroundColor = .white
        loadingView.frame = view.bounds
        loadingView.loopMode = .loop
        loadingView.play()
    }
}

#if DEBUG
import SwiftUI
struct UserLoadingViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UserLoadingViewController()
            .toPreview()
    }
}
#endif
