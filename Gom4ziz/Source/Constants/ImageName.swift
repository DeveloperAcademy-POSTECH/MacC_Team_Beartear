//
//  ImageName.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/28.
//

import Foundation

enum ImageName {
    // Asset
    static let onBoarding1Image = "onBoarding1Image"
    static let onBoarding3Image = "onBoarding3Image"
    static let bakingFirst = "BakingFirst"
    static let bakingSecond = "BakingSecond"
    static let errorImage = "ErrorImage"
    static let noMoreData = "noMoreData"
    
    // SF Symbol
    static let rightArrow = "arrow.right"
}

enum QuestionImageMasks: Int, CaseIterable {
    case zero = 0
    case one, two, three, four, five, six, seven
    
    static let prefixName = "QuestionImageMask"
}
