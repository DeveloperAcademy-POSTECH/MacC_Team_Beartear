//
//  UIButton+TextStyle.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/28.
//

import UIKit

extension UIButton {
    func textStyleAttributes(_ typography: Typohgraphy, _ color: UIColor) -> AttributeContainer {
        let (fontSize, _, fontWeight) = typography.toValue
        let font: UIFont = .systemFont(ofSize: fontSize, weight: fontWeight)
        let attributes: AttributeContainer = .init([
            .font: font,
            .foregroundColor: color])
        
        return attributes
    }
}
