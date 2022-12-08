//
//  PaddingLabel.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/12/08.
//

import UIKit

final class PaddingLabel: UILabel {

    var padding: UIEdgeInsets

    init(_ padding: UIEdgeInsets) {
        self.padding = padding
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}
