//
//  UITextView+TextStyle.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/25.
//

import UIKit

extension UITextView {
    
    func textStyle(
        _ typography: Typohgraphy,
        _ color: UIColor
    ) {
        let (fontSize, lineheight, fontWeight) = typography.toValue
        self.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        self.setTypingAttributes(fontSize: fontSize, weight: fontWeight, lineHeightMultiple: lineheight)
        self.textColor = color
    }
    
    func setTypingAttributes(
        fontSize: CGFloat,
        weight: UIFont.Weight,
        kernValue: Double = 0.0,
        lineSpacing: CGFloat = 0.0,
        lineHeightMultiple: CGFloat = 0.0) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        let attributes: [NSAttributedString.Key: Any] = [.kern: kernValue,
                                                         .paragraphStyle: paragraphStyle,
                                                         .font: UIFont.systemFont(ofSize: fontSize, weight: weight)
        ]
        self.typingAttributes = attributes

        guard attributedText.length > 0 else {
            return
        }
        let willSet: NSMutableAttributedString = .init(attributedString: attributedText)
        willSet.addAttributes(attributes, range: NSRange(location: 0, length: willSet.length - 1))
        self.attributedText = willSet
    }
    
}
