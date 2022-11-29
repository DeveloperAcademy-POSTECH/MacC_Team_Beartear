//
//  UIView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/25.
//

import UIKit

protocol Skeletonable: AnyObject {
    // 딱히 별 설정 하지 않아도 됨 (백업 용 프로퍼티임)
    var skeletonLayer: CALayer? { get set }
    var originalCornerRadius: CGFloat { get }
    // 뷰가 스켈레톤을 보여주기 전, 수행할 작업들
    func viewWillShowSkeleton(cornerRadius: CGFloat)
    // 뷰가 스켈레톤을 보여준 후, 수행할 작업들
    func viewDidHideSkeleton()
}

extension Skeletonable where Self: UIView {

    func viewWillShowSkeleton(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }

    func viewDidHideSkeleton() {
        layer.cornerRadius = originalCornerRadius
    }

    func showSkeleton(cornerRadius: CGFloat) {
        viewWillShowSkeleton(cornerRadius: cornerRadius)
        skeletonLayer = CALayer()
        skeletonLayer!.frame = bounds
        skeletonLayer!.cornerRadius = cornerRadius
        skeletonLayer!.masksToBounds = true
        skeletonLayer!.backgroundColor = UIColor.skeleton.cgColor
        layer.addSublayer(skeletonLayer!)
    }

    func hideSkeleton() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.3)
        CATransaction.setCompletionBlock { [self] in
            skeletonLayer?.removeFromSuperlayer()
            skeletonLayer = nil
            viewDidHideSkeleton()
        }

        skeletonLayer?.opacity = 0
        CATransaction.commit()
    }

}

public extension UIView {

    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }

}
