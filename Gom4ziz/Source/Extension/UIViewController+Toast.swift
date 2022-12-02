//
//  UIViewController+Toast.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/12/02.
//

import UIKit

extension UIViewController {

    /// 토스트 메시지를 띄우는 함수입니다. 호출하면 알아서 토스트메시지가 뜨고 사라집니다.
    /// - Parameters:
    ///   - text: 토스트 메시지에 표시할 텍스트
    ///   - duration: 토스트 메시지가 표시될 시간
    ///   - textAlignment: 토스트 메시지에 표시될 텍스트의 정렬
    func showToastMessage(
        text: String,
        duration: TimeInterval = 3,
        textAlignment: NSTextAlignment = .center
    ) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        guard let window = windowScene?.windows.first else { return }

        let toastView: ToastView = ToastView(text: text, duration: duration, alignment: textAlignment)
        window.addSubview(toastView)
        toastView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toastView.leftAnchor.constraint(equalTo: window.leftAnchor, constant: 16),
            toastView.rightAnchor.constraint(equalTo: window.rightAnchor, constant: -16),
            toastView.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: -34)
        ])
    }
}
