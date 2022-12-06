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

}
