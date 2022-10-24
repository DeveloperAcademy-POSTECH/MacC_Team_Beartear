//
//  KakaoMessageSender.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/23.
//

import Foundation
import RxSwift
import UIKit
import KakaoSDKShare
import RxKakaoSDKShare

final class KakaoMessageSender {

    private let disposeBag: DisposeBag = .init()

    /// 카카오 Api 를 사용해 메시지를 공유하는 함수
    /// - Parameter type: 보낼 메시지 타입
    func sendMessage(_ type: KakaoMessage) {
        guard ShareApi.isKakaoTalkSharingAvailable() else {
            dump("Kakao talk is unable")
            return
        }

        ShareApi.shared.rx.shareCustom(templateId: type.templateId, templateArgs: type.args)
            .subscribe(onSuccess: { sharingResult in
                dump(sharingResult.url)
                UIApplication.shared.open(sharingResult.url, options: [:], completionHandler: nil)
            }, onFailure: {
                print($0.localizedDescription)
            })
            .disposed(by: disposeBag)
    }

}
