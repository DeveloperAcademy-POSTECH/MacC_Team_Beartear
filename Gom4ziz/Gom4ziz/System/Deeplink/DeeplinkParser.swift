//
//  DeeplinkParser.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/24.
//

import Foundation

struct DeeplinkParser {
    func parseURLToDeeplink(_ link: URL) -> Deeplink? {
        let string = link.absoluteString
        if string.contains("invite") {
            let splited = string.components(separatedBy: "?")
            guard let plansRoomId: String = splited.last?.components(separatedBy: "&").filter({ $0.contains("plansRoomId") }).first?.components(separatedBy: "=").last else {
                return nil
            }
            return .invitePromiseRoom(plansRoomId: plansRoomId)
        }

        return nil
    }
}
