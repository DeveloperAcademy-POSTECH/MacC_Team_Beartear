//
//  MockData.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/20.
//

#if DEBUG
import Foundation

extension UserInfo {
    static let mockData: UserInfo = UserInfo(id: "123", name: "상효보이")
    static let mockDataList: [UserInfo] = [
        UserInfo(id: "123", name: "상효보이"),
        UserInfo(id: "456", name: "호종이"),
        UserInfo(id: "789", name: "에코"),
        UserInfo(id: "101112", name: "리버"),
        UserInfo(id: "131415", name: "이솝"),
        UserInfo(id: "123124125412", name: "쑤")
    ]
}

extension PlansRoom {
    static let mockData: PlansRoom = PlansRoom(id: "123", name: "통영 가즈아", date: nil, place: "통영", isEnd: false)
    static let mockDataList: [PlansRoom] = [
        PlansRoom(id: UUID().uuidString, name: "통영 가즈아", date: nil, place: "통영", isEnd: false),
        PlansRoom(id: UUID().uuidString, name: "대구 가즈아", date: nil, place: "통영", isEnd: true),
        PlansRoom(id: UUID().uuidString, name: "부산 가즈아", date: nil, place: "통영", isEnd: false),
        PlansRoom(id: UUID().uuidString, name: "서울 가지말자", date: nil, place: nil, isEnd: true),
        PlansRoom(id: UUID().uuidString, name: "울릉도 가지말자", date: nil, place: "울릉도", isEnd: false),
        PlansRoom(id: UUID().uuidString, name: "유럽 가즈아", date: nil, place: "유럽", isEnd: true),
        PlansRoom(id: UUID().uuidString, name: "바르벳 가즈아", date: nil, place: "포항", isEnd: false)
    ]
}
#endif
