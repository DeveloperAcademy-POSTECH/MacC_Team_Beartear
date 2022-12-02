//
//  RequestNewArtworkUsecaseTest.swift
//  Gom4zizTests
//
//  Created by sanghyo on 2022/11/23.
//
@testable import Gom4ziz
import XCTest

final class ArtworkHelperTest: XCTestCase {

    private var artworkHelper = ArtworkHelper()
    private let oneHourSeconds: Double = 3600
    private lazy var oneDaySeconds: Double = oneHourSeconds * 24
    
    /// getThisWeekArtworkCount test

    func test_일요일_아침기준_해당주에_받게될_남은_작품은_2개() throws {
        // given
        let sundayMorning = "20221120110000"
        let sundayMorningDate = DateFormatter.yyyyMMddHHmmssFormatter.date(from: sundayMorning)!
        
        // when
        let num = artworkHelper.getThisWeekArtworkCount(after: sundayMorningDate)
        
        // then
        XCTAssertEqual(2, num)
    }
    
    func test_일요일_오후기준_해당주에_받게될_남은_작품은_1개() throws {
        // given
        let sundayEvening = "20221120143000"
        let sundayEveningDate = DateFormatter.yyyyMMddHHmmssFormatter.date(from: sundayEvening)!
        
        // when
        let num = artworkHelper.getThisWeekArtworkCount(after: sundayEveningDate)
        
        // then
        XCTAssertEqual(1, num)
    }
    
    func test_일요일_저녁기준_해당주에_받게될_남은_작품은_1개() throws {
        // given
        let sundayNight = "20221120180000"
        let sundayNightDate = DateFormatter.yyyyMMddHHmmssFormatter.date(from: sundayNight)!
        
        // when
        let num = artworkHelper.getThisWeekArtworkCount(after: sundayNightDate)
        
        // then
        XCTAssertEqual(1, num)
    }
    
    func test_월요일_아침기준_해당주에_받게될_남은_작품은_1개() throws {
        // given
        let mondayMorning = "20221121110000"
        let mondayMorningDate = DateFormatter.yyyyMMddHHmmssFormatter.date(from: mondayMorning)!
        
        // when
        let num = artworkHelper.getThisWeekArtworkCount(after: mondayMorningDate)
        
        // then
        XCTAssertEqual(1, num)
    }
    
    func test_토요일_아침기준_해당주에_받게될_남은_작품은_1개() throws {
        // given
        let saturdayMorning = "20221126113000"
        let saturdayEveningDate = DateFormatter.yyyyMMddHHmmssFormatter.date(from: saturdayMorning)!
        
        // when
        let num = artworkHelper.getThisWeekArtworkCount(after: saturdayEveningDate)
        
        // then
        XCTAssertEqual(1, num)
    }
    
    func test_토요일_저녁기준_해당주에_받게될_남은_작품은_0개() throws {
        // given
        let saturdayEvening = "20221126173000"
        let saturdayEveningDate = DateFormatter.yyyyMMddHHmmssFormatter.date(from: saturdayEvening)!
        
        // when
        let num = artworkHelper.getThisWeekArtworkCount(after: saturdayEveningDate)
        
        // then
        XCTAssertEqual(0, num)
    }
    
    /// getThisWeekArtworkCount test all pass test 시간 12월 2일 금 오후 9시 15분

    func test_이번주_일요일_유저가_가입_할당된_작품은_1개() throws {
        // given
        let loginedDate = Date(timeIntervalSinceNow: -oneDaySeconds * 5)
        let user = User(id: "1", lastArtworkId: 2, firstLoginedDate: loginedDate.yyyyMMddHHmmssFormattedInt)
        
        // when
        let num = artworkHelper.getAllocatedArtworkCount(with: user)
        
        // then
        XCTAssertEqual(1, num)
    }
    
    func test_저번주_목요일_유저가_가입_할당된_작품은_3개() throws {
        // given
        let loginedDate = Date(timeIntervalSinceNow: -oneDaySeconds * 8)
        let user = User(id: "1", lastArtworkId: 2, firstLoginedDate: loginedDate.yyyyMMddHHmmssFormattedInt)
        
        // when
        let num = artworkHelper.getAllocatedArtworkCount(with: user)
        
        // then
        XCTAssertEqual(3, num)
    }
    
    func test_저번주_일요일_저녁_유저가_가입_할당된_작품은_3개() throws {
        // given
        let loginedDate = Date(timeIntervalSinceNow: -oneDaySeconds * 12)
        let user = User(id: "1", lastArtworkId: 2, firstLoginedDate: loginedDate.yyyyMMddHHmmssFormattedInt)
        
        // when
        let num = artworkHelper.getAllocatedArtworkCount(with: user)
        
        // then
        XCTAssertEqual(3, num)
    }
    
    func test_저저번주_토요일_아침_유저가_가입_할당된_작품은_5개() throws {
        // given
        let loginedDate = Date(timeIntervalSinceNow: -oneDaySeconds * 13 - oneHourSeconds * 12)
        let user = User(id: "1", lastArtworkId: 2, firstLoginedDate: loginedDate.yyyyMMddHHmmssFormattedInt)
        
        // when
        let num = artworkHelper.getAllocatedArtworkCount(with: user)
        
        // then
        XCTAssertEqual(5, num)
    }
    
    func test_저저번주_토요일_오후_유저가_가입_할당된_작품은_4개() throws {
        // given
        let loginedDate = Date(timeIntervalSinceNow: -oneDaySeconds * 13 - oneHourSeconds * 7)
        let user = User(id: "1", lastArtworkId: 2, firstLoginedDate: loginedDate.yyyyMMddHHmmssFormattedInt)
        
        // when
        let num = artworkHelper.getAllocatedArtworkCount(with: user)
        
        // then
        XCTAssertEqual(4, num)
    }
    
    /// getNextArtworkDate test
    
    func test_일요일_아침_유저가_받게될_날짜는_일요일_오후() throws {
        // given
        let dateString = "20221127113000"
        let date = DateFormatter.yyyyMMddHHmmssFormatter.date(from: dateString)!
        
        // when
        let receiveDate = artworkHelper.getNextArtworkDate(from: date)
        let expectedDateString = "20221127140000"
        let expectedDate = DateFormatter.yyyyMMddHHmmssFormatter.date(from: expectedDateString)!
        
        // then
        XCTAssertEqual(receiveDate, expectedDate)
    }
    
    func test_일요일_오후_유저가_받게될_날짜는_토요일_오후() throws {
        // given
        let dateString = "20221127143000"
        let date = DateFormatter.yyyyMMddHHmmssFormatter.date(from: dateString)!
        
        // when
        let receiveDate = artworkHelper.getNextArtworkDate(from: date)
        let expectedDateString = "20221203140000"
        let expectedDate = DateFormatter.yyyyMMddHHmmssFormatter.date(from: expectedDateString)!
        
        // then
        XCTAssertEqual(receiveDate, expectedDate)    }
    
    func test_화요일_아침_유저가_받게될_날짜는_토요일_오후() throws {
        // given
        let dateString = "20221129113000"
        let date = DateFormatter.yyyyMMddHHmmssFormatter.date(from: dateString)!
        
        // when
        let receiveDate = artworkHelper.getNextArtworkDate(from: date)
        let expectedDateString = "20221203140000"
        let expectedDate = DateFormatter.yyyyMMddHHmmssFormatter.date(from: expectedDateString)!
        
        // then
        XCTAssertEqual(receiveDate, expectedDate)
    }
    
    func test_토요일_아침_유저가_받게될_날짜는_토요일_오후() throws {
        // given
        let dateString = "20221203110000"
        let date = DateFormatter.yyyyMMddHHmmssFormatter.date(from: dateString)!
        
        // when
        let receiveDate = artworkHelper.getNextArtworkDate(from: date)
        let expectedDateString = "20221203140000"
        let expectedDate = DateFormatter.yyyyMMddHHmmssFormatter.date(from: expectedDateString)!
        
        // then
        XCTAssertEqual(receiveDate, expectedDate)
    }
    
    func test_토요일_오후_유저가_받게될_날짜는_다음주_일요일_오후() throws {
        // given
        let dateString = "20221203140030"
        let date = DateFormatter.yyyyMMddHHmmssFormatter.date(from: dateString)!
        
        // when
        let receiveDate = artworkHelper.getNextArtworkDate(from: date)
        let expectedDateString = "20221204140000"
        let expectedDate = DateFormatter.yyyyMMddHHmmssFormatter.date(from: expectedDateString)!
        
        // then
        XCTAssertEqual(receiveDate, expectedDate)
    }
}
