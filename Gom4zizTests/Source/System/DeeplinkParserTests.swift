//
//  DeeplinkParserTests.swift
//  Gom4zizTests
//
//  Created by JongHo Park on 2022/10/24.
//

@testable import Gom4ziz
import XCTest

final class DeeplinkParserTests: XCTestCase {

    private let deeplinkParser: DeeplinkParser = .init()

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_딥링크_성공적으로_초대링크로_변환되는지() {
        guard let deeplinkURL = URL(string: "kakao1231203://kakaolink?type=invite&plansRoomId=123&plansRoomName=room") else {
            XCTFail(#function + " url 초기화 실패")
            return
        }
        let result = deeplinkParser.parseURLToDeeplink(deeplinkURL)

        XCTAssertEqual(result, Deeplink.invitePromiseRoom(plansRoomId: "123"))
    }

    func test_이상한_딥링크면_변환되면_안됨() {
        guard let strangeURL: URL = URL(string: "kak123dsow//qowdk?tepwekfowpemf") else {
            XCTFail(#function + " url 초기화 실패")
            return
        }
        let result = deeplinkParser.parseURLToDeeplink(strangeURL)
        XCTAssertNil(result)
    }

    func test_카카오링크라도_이상한형식이면_변환실패() {
        guard let strangeURL: URL = URL(string: "kakao1231203://kakaolink?type=invite&plansRoo=122333") else {
            XCTFail(#function + " url 초기화 실패")
            return
        }
        let result = deeplinkParser.parseURLToDeeplink(strangeURL)
        XCTAssertNil(result)
    }

}
