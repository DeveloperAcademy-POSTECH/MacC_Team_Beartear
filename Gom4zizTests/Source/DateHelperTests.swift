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
    
    func test_오늘을_기준으로_이번주_토요일_오후2시_반환() throws {
        // given
        let today = Date.koreanNowDate
        let sunday = "202211201400"
    
        // when
        let sun = dateHelper.makeDateInSameWeek(with: today, to: .sun, HHmm: "1400")
        let formattedsunday = DateFormatter.yyyyMMddHHmmFormatter.string(from: sun)
        
        // then
        XCTAssertEqual(sunday, formattedsunday)
    }
    
    func test_오늘과_다다음주_화요일_사이에_한개의_주가있다() throws {
        //given
        let today = Date.koreanNowDate
        let nextNextTuesday = DateFormatter.yyyyMMddFormatter.date(from: "20221206")!.convertedKoreanDate
        
        //when
        let weekDays = dateHelper.countWeekBetweenDays(from: today, to: nextNextTuesday)
        
        //then
        XCTAssertEqual(weekDays, 1)
    }
    
    func test_오늘과_다음주_화요일_사이에_0개의_주가있다() throws {
        //given
        let today = Date.koreanNowDate
        let nextTuesday = DateFormatter.yyyyMMddFormatter.date(from: "20221129")!.convertedKoreanDate
        
        //when
        let weekDays = dateHelper.countWeekBetweenDays(from: today, to: nextTuesday)
        
        //then
        XCTAssertEqual(weekDays, 0)
    }
    
    func test_오늘과_내일_사이에_0개의_주가있다() throws {
        //given
        let today = Date.koreanNowDate
        let tomorrow = DateFormatter.yyyyMMddFormatter.date(from: "20221124")!.convertedKoreanDate
        
        //when
        let weekDays = dateHelper.countWeekBetweenDays(from: today, to: tomorrow)
        
        //then
        XCTAssertEqual(weekDays, 0)
    }
    
    func test_오늘과_다다음주_일요일_사이에_1개의_주가있다() throws {
        //given
        let today = Date.koreanNowDate
        let nextWednesday = DateFormatter.yyyyMMddFormatter.date(from: "20221204")!.convertedKoreanDate
        
        //when
        let weekDays = dateHelper.countWeekBetweenDays(from: today, to: nextWednesday)
        
        //then
        XCTAssertEqual(weekDays, 1)
    }
}
