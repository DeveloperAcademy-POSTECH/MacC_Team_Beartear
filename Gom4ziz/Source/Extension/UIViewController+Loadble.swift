//
//  UIViewController+Loadble.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/29.
//

import UIKit

extension UIViewController {
    
    func setUpLoadingView(_ loadingView: LoadingView) {
        self.view.addSubview(loadingView)
        loadingView.startLoadingAnimation()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loadingView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func removeLoadingView(_ loadingView: LoadingView) {
        loadingView.removeFromSuperview()
    }
    
    func setUpErrorView(_ errorView: ErrorView) {
        self.view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            errorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            errorView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            errorView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            errorView.topAnchor.constraint(equalTo: self.view.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func removeErrorView(_ errorView: ErrorView) {
        errorView.removeFromSuperview()
    }
    
}
