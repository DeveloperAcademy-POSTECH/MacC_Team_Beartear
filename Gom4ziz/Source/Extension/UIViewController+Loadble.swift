//
//  UIViewController+Loadble.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/29.
//

import UIKit

extension UIViewController {
    
    func setUpLoadingView() {
        let loadingView: LoadingView = .init()
        self.view.addSubview(loadingView)
        loadingView.startLoadingAnimation()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func removeLoadingView() {
        for subView in self.view.subviews where subView is LoadingView {
            subView.removeFromSuperview()
        }
    }
    
    func setUpErrorView(_ message: ErrorViewMessage, _ isShowLogo: Bool) {
        let errorView: ErrorView = .init(message: message, isShowLogo: isShowLogo)
        errorView.tag = 2
        self.view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            errorView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            errorView.topAnchor.constraint(equalTo: self.view.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func getErrorView() -> ErrorView? {
        self.view.viewWithTag(2) as? ErrorView
    }
    
}
