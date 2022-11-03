//
//  UserInfoIdCache.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/21.
//

import Foundation

final class UserInfoIdCache {
    private var idCache: Set<String> = []

    func cached(_ uid: String) -> Bool {
        idCache.contains(uid)
    }

    func cache(_ uid: String) {
        idCache.insert(uid)
    }
}
