//
//  PlamsRoomIdCache.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/10/23.
//

import Foundation

final class PlansRoomIdCache {
    private var idCache: Set<String> = []

    func cached(_ roomId: String) -> Bool {
        idCache.contains(roomId)
    }

    func cache(_ roomId: String) {
        idCache.insert(roomId)
    }
}
