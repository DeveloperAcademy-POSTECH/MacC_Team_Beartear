//
//  Typography.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/23.
//

import UIKit

enum Typohgraphy {
    case Display1
    case Display2
    case Display3
    case Title
    case Headline1
    case Headline2
    case SubHeadline
    case Body1
    case Body2
    case Caption
    case NavigationTitle
    case NavigationButton
}

extension Typohgraphy {
    var toValue: (fontSize: CGFloat, lineHieightMultiple: CGFloat, UIFont.Weight) {
        switch self {
        case .Display1: return (28, 1.5, .bold)
        case .Display2: return (24, 1.5, .bold)
        case .Display3: return (22, 1.5, .bold)
        case .Title: return (20, 1.2, .bold)
        case .Headline1: return (17, 1.4, .bold)
        case .Headline2: return (16, 1.2, .heavy)
        case .SubHeadline: return (16, 1.2, .medium)
        case .Body1: return (18, 1.5, .light)
        case .Body2: return (14, 1.5, .light)
        case .Caption: return (14, 1.5, .bold)
        case .NavigationTitle: return (16, 1.5, .semibold)
        case .NavigationButton: return (16, 1.5, .regular)
        }
    }
}
