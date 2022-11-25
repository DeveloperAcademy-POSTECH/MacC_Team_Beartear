//
//  LineHeight.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/23.
//

import UIKit

enum TextStyle {
    case textStyle(size: CGFloat, type: Typohgraphy)
}

extension UILabel {
    func textStyle(_ typography: Typohgraphy, _ color: UIColor) {
        let (fontSize, lineheight, fontWeight) = typography.toValue
        self.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        self.setLineSpacing(lineSpacing: lineheight)
        self.textColor = color
    }
    
    func setLineSpacing(kernValue: Double = 0.0,
                          lineSpacing: CGFloat = 0.0,
                          lineHeightMultiple: CGFloat = 0.0) {
          guard let labelText = self.text else { return }
          
          let paragraphStyle = NSMutableParagraphStyle()
          paragraphStyle.lineSpacing = lineSpacing
          paragraphStyle.lineHeightMultiple = lineHeightMultiple
          
          let attributedString: NSMutableAttributedString
          if let labelAttributedText = self.attributedText {
              attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
          } else {
              attributedString = NSMutableAttributedString(string: labelText)
          }
          
          attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                        value: paragraphStyle,
                                        range: NSMakeRange(0, attributedString.length))
          attributedString.addAttribute(NSAttributedString.Key.kern,
                                        value: kernValue,
                                        range: NSMakeRange(0, attributedString.length))
          
          self.attributedText = attributedString
      }
}
