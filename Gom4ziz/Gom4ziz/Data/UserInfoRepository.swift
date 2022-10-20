//
//  UserInfoRepository.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/20.
//

import Foundation
import FirebaseFirestore
import RxSwift

protocol UserInfoRepository {
    func requestUserInfo(of uid: String) -> Observable<UserInfo>
    func addUserInfo(userInfo: UserInfo)
}
