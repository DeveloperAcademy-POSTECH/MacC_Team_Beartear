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
    func textStyle(_ style: TextStyle, _ color: UIColor) {
        if case .textStyle(let size, let type) = style {
            let (lineheight, fontWeight) = type.toValue
            self.setLineSpacing(lineSpacing: lineheight)
            
            switch size {
            case 14:
                self.font = .systemFont(ofSize: 14, weight: fontWeight)
                self.textColor = color
            case 15:
                self.font = .systemFont(ofSize: 15, weight: fontWeight)
                self.textColor = color
            case 16:
                self.font = .systemFont(ofSize: 16, weight: fontWeight)
                self.textColor = color
            case 17:
                self.font = .systemFont(ofSize: 17, weight: fontWeight)
                self.textColor = color
            case 18:
                self.font = .systemFont(ofSize: 18, weight: fontWeight)
                self.textColor = color
            case 20:
                self.font = .systemFont(ofSize: 20, weight: fontWeight)
                self.textColor = color
            case 24:
                self.font = .systemFont(ofSize: 24, weight: fontWeight)
                self.textColor = color
            default:
                break
            }
        }
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
