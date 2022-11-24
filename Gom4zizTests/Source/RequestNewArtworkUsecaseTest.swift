//
//  RequestNewArtworkUsecaseTest.swift
//  Gom4zizTests
//
//  Created by sanghyo on 2022/11/23.
//
@testable import Gom4ziz
import XCTest

final class RequestNewArtworkUsecaseTest: XCTestCase {

    private var requestNewArtworkUsecase: RequestNextArtworkUsecase!
    private let oneHourSeconds: Double = 3600
    private lazy var oneDaySeconds: Double = oneHourSeconds * 24
    
    override func setUpWithError() throws {
           try super.setUpWithError()
           requestNewArtworkUsecase = RealRequestNextArtworkUsecase()
       }
   
    override func tearDownWithError() throws {
        requestNewArtworkUsecase = nil
    }
    
    func test_이번주_일요일_아침기준_이번주에_받게될_남은_작품은_2개() throws {
        // given
        let sundayMorning = "202211201100"
        let sundayMorningDate = DateFormatter.yyyyMMddHHmmFormatter.date(from: sundayMorning)!
        var num = -1
        
        // when
        if let usecase = requestNewArtworkUsecase as? RealRequestNextArtworkUsecase {
            num = usecase.getThisWeekArtworkNum(after: sundayMorningDate)
        }
        
        // then
        XCTAssertEqual(2, num)
    }
    
    func test_이번주_월요일_아침기준_이번주에_받게될_남은_작품은_1개() throws {
        // given
        let mondayMorning = "202211211100"
        let mondayMorningDate = DateFormatter.yyyyMMddHHmmFormatter.date(from: mondayMorning)!
        var num = -1
        
        // when
        if let usecase = requestNewArtworkUsecase as? RealRequestNextArtworkUsecase {
            num = usecase.getThisWeekArtworkNum(after: mondayMorningDate)
        }
        
        // then
        XCTAssertEqual(1, num)
    }
    
    func test_이번주_토요일_저녁기준_이번주에_받게될_남은_작품은_0개() throws {
        // given
        let saturdayEvening = "202211261730"
        let saturdayEveningDate = DateFormatter.yyyyMMddHHmmFormatter.date(from: saturdayEvening)!
        var num = -1
        
        // when
        if let usecase = requestNewArtworkUsecase as? RealRequestNextArtworkUsecase {
            num = usecase.getThisWeekArtworkNum(after: saturdayEveningDate)
        }
        
        // then
        XCTAssertEqual(0, num)
    }


    func test_이번주_월요일_유저가_가입_할당된_작품은_0개() throws {
        // given
        let user = User(id: "1", lastArtworkId: 2, firstLoginedDate: 202211211200)
        var num = -1
        
        // when
        if let usecase = requestNewArtworkUsecase as? RealRequestNextArtworkUsecase {
            num = usecase.getAllocatedArtworkNum(with: user)
        }
        
        // then
        XCTAssertEqual(0, num)
    }
    
    func test_저번주_금요일_유저가_가입_할당된_작품은_2개() throws {
        // given
        let user = User(id: "1", lastArtworkId: 2, firstLoginedDate: 202211181200)
        var num = -1
        
        // when
        if let usecase = requestNewArtworkUsecase as? RealRequestNextArtworkUsecase {
            num = usecase.getAllocatedArtworkNum(with: user)
        }
        
        // then
        XCTAssertEqual(2, num)
    }
    
    func test_저번주_월요일_유저가_가입_할당된_작품은_2개() throws {
        // given
        let user = User(id: "1", lastArtworkId: 2, firstLoginedDate: 202211141200)
        var num = -1
        
        // when
        if let usecase = requestNewArtworkUsecase as? RealRequestNextArtworkUsecase {
            num = usecase.getAllocatedArtworkNum(with: user)
        }
        
        // then
        XCTAssertEqual(2, num)
    }
    
    
    
//    func test_() throws {
//        // given
//        // when
//        // then
//    }
//
//    func test_() throws {
//        // given
//        // when
//        // then
//    }
}
