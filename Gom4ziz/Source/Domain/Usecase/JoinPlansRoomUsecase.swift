//
//  JoinPlansRoomUsecase.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/26.
//

import RxSwift

protocol JoinPlansRoomUsecase {
    func joinPlansRoom(uid: String, for plansRoom: PlansRoom) -> Single<PlansRoom>
}

struct RealJoinPlansRoomUsecase: JoinPlansRoomUsecase {
    private let plansRoomRepository: PlansRoomRepository

    init(plansRoomRepository: PlansRoomRepository = FirebasePlansRoomRepository.shared) {
        self.plansRoomRepository = plansRoomRepository
    }

    func joinPlansRoom(uid: String, for plansRoom: PlansRoom) -> Single<PlansRoom> {
        plansRoomRepository.joinPlansRoom(uid: uid, plansRoom: plansRoom)
            .map { _ in
                plansRoom.joinPlansRoom(uid: uid)
            }
    }
}
