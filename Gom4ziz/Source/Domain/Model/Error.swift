//
//  Error.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/25.
//

import Foundation

enum ArtworkRequestError: Error {
    case noMoreDataError
}

enum UserRequestError: Error {
    case notRegisteredUser
}
