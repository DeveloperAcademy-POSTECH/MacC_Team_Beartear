//
//  Typography.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/23.
//

import UIKit

enum Typohgraphy {
    case title
    case sectionHeader
    case navigationHeader
    case primary
    case secondary
    case description
}

extension Typohgraphy {
    var toValue: (CGFloat, UIFont.Weight) {
        switch self {
        case .title:
            return (1.5, .bold)
        case .sectionHeader:
            return (1.5, .heavy)
        case .navigationHeader:
            return (1.5, .semibold)
        case .primary:
            return (1.8, .light)
        case .secondary:
            return (1.5, .light)
        case .description:
            return (1.5, .regular)
        }
    }
}
