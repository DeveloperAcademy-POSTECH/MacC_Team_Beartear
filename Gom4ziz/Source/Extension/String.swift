//
//  String.swift
//  Gom4ziz
//
//  Created by 이가은 on 2022/12/09.
//

import Foundation

extension String {
    var convertNewLine: String {
        return self.replacingOccurrences(of: "\\n", with: "\n")
    }
}
