//
//  UIScrollView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/26.
//

import UIKit

extension UIScrollView {

    func scrollToBottom() {
        let bottomOffset = scrollBottomOffset()
        if bottomOffset.y > 0 {
            setContentOffset(bottomOffset, animated: true)
        }
    }

    private func scrollBottomOffset() -> CGPoint {
        return CGPoint(x: -contentInset.left, y: contentSize.height - bounds.size.height + contentInset.bottom)
    }

}
