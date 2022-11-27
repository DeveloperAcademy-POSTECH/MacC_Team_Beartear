//
//  DateHelperTests.swift
//  Gom4zizTests
//
//  Created by sanghyo on 2022/11/23.
//
@testable import Gom4ziz
import XCTest

final class DateHelperTests: XCTestCase {

    private let dateHelper: DateHelper = DateHelper()
    private let oneDaySeconds: Double = 3600 * 24
    
    func test_오늘과_다다음주_화요일_사이에_한개의_주가있다() throws {
        // given
        let today = Date()
        let nextNextTuesday = Date(timeIntervalSinceNow: oneDaySeconds * 12)
        
        // when
        let weekDays = dateHelper.countWeekBetweenDays(from: today, to: nextNextTuesday)
        
        // then
        XCTAssertEqual(weekDays, 1)
    }
    
    func test_오늘과_다음주_화요일_사이에_0개의_주가있다() throws {
        // given
        let today = Date()
        let nextTuesday = Date(timeIntervalSinceNow: oneDaySeconds * 5)
        
        // when
        let weekDays = dateHelper.countWeekBetweenDays(from: today, to: nextTuesday)
        
        // then
        XCTAssertEqual(weekDays, 0)
    }
    
    func test_오늘과_내일_사이에_0개의_주가있다() throws {
        // given
        let today = Date()
        let tomorrow = Date(timeIntervalSinceNow: oneDaySeconds * 1)
        
        // when
        let weekDays = dateHelper.countWeekBetweenDays(from: today, to: tomorrow)
        
        // then
        XCTAssertEqual(weekDays, 0)
    }
    
    func test_오늘과_다다음주_일요일_사이에_1개의_주가있다() throws {
        // given
        let today = Date()
        let nextSunday = Date(timeIntervalSinceNow: oneDaySeconds * 10)
        
        // when
        let weekDays = dateHelper.countWeekBetweenDays(from: today, to: nextSunday)
        
        // then
        XCTAssertEqual(weekDays, 1)
    }
}
