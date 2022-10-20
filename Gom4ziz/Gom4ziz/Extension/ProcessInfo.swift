//
//  ProcessInfo.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/20.
//

import Foundation

// 현재 프로세스가 테스트 프로세스인지, 아니면 정상적인 프로덕션 프로세스인지 나타내는 Bool 값을 익스텐션으로 추가
extension ProcessInfo {
    var isRunningTests: Bool {
        environment["XCTestConfigurationFilePath"] != nil
    }
}
