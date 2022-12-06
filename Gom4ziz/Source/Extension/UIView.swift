//
//  UIView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/25.
//

import UIKit

public extension UIView {

    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }

    var topBarHeight: CGFloat {
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
        guard let rootVC = window?.rootViewController as? UINavigationController else {
            return 0
        }
        let navigationBarHeight = rootVC.navigationBar.frame.height
        return statusBarHeight + navigationBarHeight
    }

}
