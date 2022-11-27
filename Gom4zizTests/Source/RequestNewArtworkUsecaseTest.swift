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
        let sundayMorning = "20221120110000"
        let sundayMorningDate = DateFormatter.yyyyMMddHHmmssFormatter.date(from: sundayMorning)!
        var num = -1
        
        // when
        if let usecase = requestNewArtworkUsecase as? RealRequestNextArtworkUsecase {
            num = usecase.getThisWeekArtworkCount(after: sundayMorningDate)
        }
        
        // then
        XCTAssertEqual(2, num)
    }
    
    func test_이번주_월요일_아침기준_이번주에_받게될_남은_작품은_1개() throws {
        // given
        let mondayMorning = "20221121110000"
        let mondayMorningDate = DateFormatter.yyyyMMddHHmmssFormatter.date(from: mondayMorning)!
        var num = -1
        
        // when
        if let usecase = requestNewArtworkUsecase as? RealRequestNextArtworkUsecase {
            num = usecase.getThisWeekArtworkCount(after: mondayMorningDate)
        }
        
        // then
        XCTAssertEqual(1, num)
    }
    
    func test_이번주_토요일_저녁기준_이번주에_받게될_남은_작품은_0개() throws {
        // given
        let saturdayEvening = "20221126173000"
        let saturdayEveningDate = DateFormatter.yyyyMMddHHmmssFormatter.date(from: saturdayEvening)!
        var num = -1
        
        // when
        if let usecase = requestNewArtworkUsecase as? RealRequestNextArtworkUsecase {
            num = usecase.getThisWeekArtworkCount(after: saturdayEveningDate)
        }
        
        // then
        XCTAssertEqual(0, num)
    }

    func test_이번주_일요일_유저가_가입_할당된_작품은_0개() throws {
        // given
        let loginedDate = Date(timeIntervalSinceNow: -oneDaySeconds * 4 + oneHourSeconds * 3)
        let user = User(id: "1", lastArtworkId: 2, firstLoginedDate: loginedDate.yyyyMMddHHmmssFormattedInt!)
        var num = -1
        
        // when
        if let usecase = requestNewArtworkUsecase as? RealRequestNextArtworkUsecase {
            num = usecase.getAllocatedArtworkCount(with: user)
        }
        
        // then
        XCTAssertEqual(0, num)
    }
    
    func test_저번주_금요일_유저가_가입_할당된_작품은_2개() throws {
        // given
        let loginedDate = Date(timeIntervalSinceNow: -oneDaySeconds * 6)
        let user = User(id: "1", lastArtworkId: 2, firstLoginedDate: loginedDate.yyyyMMddHHmmssFormattedInt!)
        var num = -1
        
        // when
        if let usecase = requestNewArtworkUsecase as? RealRequestNextArtworkUsecase {
            num = usecase.getAllocatedArtworkCount(with: user)
        }
        
        // then
        XCTAssertEqual(2, num)
    }
    
    func test_저번주_월요일_유저가_가입_할당된_작품은_2개() throws {
        // given
        let loginedDate = Date(timeIntervalSinceNow: -oneDaySeconds * 10)
        let user = User(id: "1", lastArtworkId: 2, firstLoginedDate: loginedDate.yyyyMMddHHmmssFormattedInt!)
        var num = -1
        
        // when
        if let usecase = requestNewArtworkUsecase as? RealRequestNextArtworkUsecase {
            num = usecase.getAllocatedArtworkCount(with: user)
        }
        
        // then
        XCTAssertEqual(2, num)
    }
}
