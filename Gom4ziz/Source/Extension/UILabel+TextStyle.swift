//
//  LineHeight.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/23.
//

import UIKit

extension UILabel {
    func textStyle(
        _ typography: Typohgraphy,
        kernValue: Double = 0,
        lineSpacing: CGFloat = 0,
        lineHeightMultiple: CGFloat? = nil,
        alignment: NSTextAlignment = .left,
        _ color: UIColor) {
            let (fontSize, lineheight, fontWeight) = typography.toValue
            self.font = .systemFont(ofSize: fontSize, weight: fontWeight)
            let lineHeight: CGFloat = lineHeightMultiple ?? lineheight
            setLineSpacing(kernValue: kernValue, lineSpacing: lineSpacing, lineHeightMultiple: lineHeight, alignment: alignment)
            self.textColor = color
        }
    
    func setLineSpacing(
        kernValue: Double = 0.0,
        lineSpacing: CGFloat = 0.0,
        lineHeightMultiple: CGFloat = 0.0,
        alignment: NSTextAlignment = .left) {
            guard let labelText = self.text else { return }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            paragraphStyle.lineHeightMultiple = lineHeightMultiple
            paragraphStyle.alignment = alignment
            
            let lineHeight = font.pointSize * lineHeightMultiple
            let baseLineOffset = (lineHeight - font.pointSize) / 2
            
            let attributedString: NSMutableAttributedString
            if let labelAttributedText = self.attributedText {
                attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
            } else {
                attributedString = NSMutableAttributedString(string: labelText)
            }
        
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                          value: paragraphStyle,
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: kernValue,
                                          range: NSRange(location: 0, length: attributedString.length))

            attributedString.addAttribute(.baselineOffset, value: baseLineOffset, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }
}
