//
//  KakaoMessage.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/23.
//

/// 공유할 카카오 메시지, 혹은 딥링크를 타고 들어온 카카오 링크의 타입을 나타내는 enum
enum KakaoMessage {

    case invite(room: PlansRoom)

    var args: [String: String] {
        switch self {
        case .invite(let plansRoom):
            return [
                "plansRoomId": plansRoom.id,
                "plansRoomName": plansRoom.name,
                "messageType": "invite"
            ]
        }
    }

    var templateId: Int64 {
        switch self {
        case .invite:
            return 84575
        }
    }

}
