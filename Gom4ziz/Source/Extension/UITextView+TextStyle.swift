//
//  UITextView+TextStyle.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/25.
//

import UIKit

extension UITextView {
    
    func textStyle(_ typography: Typohgraphy, _ color: UIColor) {
        let (fontSize, lineheight, fontWeight) = typography.toValue
        self.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        self.setTypingAttributes(lineSpacing: lineheight)
        self.textColor = color
    }
    
    func setTypingAttributes(kernValue: Double = 0.0,
                        lineSpacing: CGFloat = 0.0,
                        lineHeightMultiple: CGFloat = 0.0) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributes: [NSAttributedString.Key: Any] = [.kern: -0.6,
                                                         .paragraphStyle: paragraphStyle]
        self.typingAttributes = attributes
    }
    
}
