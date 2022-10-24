//
//  SendInviteUsecase.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/23.
//

protocol SendInviteUsecase {
    func sendInvite(of plansRoom: PlansRoom)
}

struct RealSendInviteUsecase: SendInviteUsecase {

    private let messageSender: KakaoMessageSender

    init(_ messageSender: KakaoMessageSender) {
        self.messageSender = messageSender
    }

    func sendInvite(of plansRoom: PlansRoom) {
        messageSender.sendMessage(.invite(room: plansRoom))
    }

}
