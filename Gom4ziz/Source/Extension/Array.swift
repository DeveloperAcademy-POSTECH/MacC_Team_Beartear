//
//  Array.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/23.
//

import Foundation

extension Array {
    var beforeLast: Element? {
        dropLast().last
    }
}
