//
//  UserInfoRepositoryTests.swift
//  Gom4zizTests
//
//  Created by JongHo Park on 2022/10/21.
//

import RxBlocking
@testable import Gom4ziz
import XCTest

final class UserInfoRepositoryTests: XCTestCase {

    private let testUserInfo: UserInfo = .mockData
    private var repository: UserInfoRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = FirebaseUserInfoRepository.shared
    }

    override func tearDownWithError() throws {
        _ = try repository.deleteUserInfo(of: testUserInfo.id).toBlocking().first()
        repository = nil
        try super.tearDownWithError()
    }

    func testAddRequestDeleteUserInfo() throws {
        do {
            _ = try repository.addUserInfo(userInfo: testUserInfo).toBlocking().first()
            guard let userInfo = try repository.requestUserInfo(of: testUserInfo.id).toBlocking().first() else {
                XCTFail(#function + " user info should be exist")
                return
            }
            XCTAssertEqual(testUserInfo, userInfo)
            _ = try repository.deleteUserInfo(of: testUserInfo.id).toBlocking().first()
            let result = repository.requestUserInfo(of: testUserInfo.id).toBlocking().materialize()
            switch result {
            case .completed(elements: let arr):
                XCTAssert(arr.isEmpty)
            case .failed(elements: let userInfos, error: let error):
                XCTAssert(userInfos.isEmpty)
                XCTAssertEqual(error.localizedDescription, RxFirestoreError.documentIsNotExist.localizedDescription)
            }
        } catch {
            XCTFail(#function + " \(error.localizedDescription)")
        }
    }
}
