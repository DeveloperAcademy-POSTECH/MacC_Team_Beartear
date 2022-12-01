//
//  UIViewController+ErrorAlert.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/12/01.
//

import UIKit

extension UIViewController {

    func showErrorAlert(title: String, suggestion: String, onRetryButtonTapped: @escaping () -> Void) {
        guard let window = view.window else { return }
        let errorAlert: ErrorAlert = .init(title: title, recoverySuggestion: suggestion, onRetryButtonTapped: onRetryButtonTapped)
        errorAlert.frame = window.bounds
        window.addSubview(errorAlert)
    }

}
