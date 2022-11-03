//
//  DeepLinkHandler.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/24.
//

import Foundation

final class DeeplinkHandler {

    private let deeplinkParser: DeeplinkParser = .init()

    func handle(_ url: URL) {
        guard let deeplink = deeplinkParser.parseURLToDeeplink(url) else {
            return
        }
        // TODO: 딥링크를 처리해서, 약속방에 참가할 수 있도록 구현해야함
        print(deeplink)
    }

}
