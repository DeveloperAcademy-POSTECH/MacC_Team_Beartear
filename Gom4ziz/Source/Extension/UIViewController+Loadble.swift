//
//  UIViewController+Loadble.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/29.
//

import UIKit

extension UIViewController {
    
    func showErrorView(_ message: ErrorViewMessage, _ isShowLogo: Bool, onRetryButtonTapped: @escaping () -> Void = { }) {
        let errorView: ErrorView = .init(message: message, isShowLogo: isShowLogo, onRetryButtonTapped: onRetryButtonTapped)
        errorView.tag = ViewTag.errorView.rawValue
        self.view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            errorView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            errorView.topAnchor.constraint(equalTo: self.view.topAnchor),
            errorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

}
