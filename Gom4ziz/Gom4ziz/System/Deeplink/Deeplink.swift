//
//  DeeplinkParser.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/24.
//

import Foundation

enum Deeplink {
    case invitePromiseRoom(plansRoomId: String)
}

extension Deeplink: CustomStringConvertible {
    var description: String {
        switch self {
        case .invitePromiseRoom(let id):
            return "초대 딥링크 약속방 id: \(id)"
        }
    }
}
