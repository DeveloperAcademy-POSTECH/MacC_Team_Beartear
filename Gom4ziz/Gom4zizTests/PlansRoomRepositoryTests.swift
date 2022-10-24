//
//  PlansRoomRepositoryTests.swift
//  Gom4zizTests
//
//  Created by 정재윤 on 2022/10/23.
//

import RxBlocking
@testable import Gom4ziz
import XCTest

final class PlansRoomRepositoryTests: XCTestCase {

    private let testPlansRoom: PlansRoom = .mockData
    private var repository: PlansRoomRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        repository = FirebasePlansRoomRepository.shared
    }

    override func tearDownWithError() throws {
        _ = try repository.deletePlansRoom(of: testPlansRoom.id).toBlocking().first()
        repository = nil
        try super.tearDownWithError()
    }

    func testFetchPlansRoomList() async throws {
        do {
            // add
            _ = try repository.addPlansRoom(for: testPlansRoom).toBlocking().first()
            guard let rooms = try repository.fetchPlansRoomList(of: "123", for: "123").toBlocking().first() else {
                XCTFail(#function + " plans room should be exist!!")
                return
            }
            XCTAssertEqual(rooms.first?.id, "1111")
            _ = try repository.deletePlansRoom(of: testPlansRoom.id).toBlocking().first()
            let result = repository.requestPlansRoom(of: testPlansRoom.id).toBlocking().materialize()
            switch result {
            case .completed(elements: let response):
                XCTAssert(response.isEmpty)
            case .failed(elements: let plansRooms, error: let error):
                XCTAssert(plansRooms.isEmpty)
                XCTAssertEqual(error.localizedDescription, RxFirestoreError.documentIsNotExist.localizedDescription)
            }
        } catch {
            XCTFail(#function + " \(error.localizedDescription)")
        }
    }

    func testAddRequestDeletePlansRoom() throws {
        do {
            // add
            _ = try repository.addPlansRoom(for: testPlansRoom).toBlocking().first()
            // request
            guard let plansRoom = try repository.requestPlansRoom(of: testPlansRoom.id).toBlocking().first() else {
                XCTFail(#function + " plans room should be exist!!")
                return
            }

            // delete
            XCTAssertEqual(testPlansRoom, plansRoom)
            _ = try repository.deletePlansRoom(of: testPlansRoom.id).toBlocking().first()
            let result = repository.requestPlansRoom(of: testPlansRoom.id).toBlocking().materialize()
            switch result {
            case .completed(elements: let response):
                XCTAssert(response.isEmpty)
            case .failed(elements: let plansRooms, error: let error):
                XCTAssert(plansRooms.isEmpty)
                XCTAssertEqual(error.localizedDescription, RxFirestoreError.documentIsNotExist.localizedDescription)
            }
            repository = nil
        } catch {
            XCTFail(#function + " \(error.localizedDescription)")
        }
    }

    func testAddRequestUpdatePlansRoom() throws {
        do {
            // add
            _ = try repository.addPlansRoom(for: testPlansRoom).toBlocking().first()
            // request
            guard let plansRoom = try repository.requestPlansRoom(of: testPlansRoom.id).toBlocking().first() else {
                XCTFail(#function + " plans room should be exist!!")
                return
            }

            // update
            XCTAssertNotEqual(testPlansRoom, plansRoom)
            _ = try repository.updatePlansRoom(of: testPlansRoom.id, for: plansRoom).toBlocking().first()
            let result = repository.requestPlansRoom(of: testPlansRoom.id).toBlocking().materialize()
            switch result {
            case .completed(elements: let response):
                XCTAssert(response.isEmpty)
            case .failed(elements: let plansRooms, error: let error):
                XCTAssert(plansRooms.isEmpty)
                XCTAssertEqual(error.localizedDescription, RxFirestoreError.documentIsNotExist.localizedDescription)
            }
            repository = nil
        } catch {
            XCTFail(#function + " \(error.localizedDescription)")
        }
    }

    func testAddRequestUpdateDeletePlansRoom() throws {
        do {
            // add
            _ = try repository.addPlansRoom(for: testPlansRoom).toBlocking().first()
            // request
            guard let plansRoom = try repository.requestPlansRoom(of: testPlansRoom.id).toBlocking().first() else {
                XCTFail(#function + " plans room should be exist!!")
                return
            }

            // update
            XCTAssertNotEqual(testPlansRoom, plansRoom)
            _ = try repository.updatePlansRoom(of: testPlansRoom.id, for: plansRoom).toBlocking().first()

            // request
            guard let plansRoom = try repository.requestPlansRoom(of: testPlansRoom.id).toBlocking().first() else {
                XCTFail(#function + " plans room should be exist!!")
                return
            }

            // delete
            XCTAssertEqual(testPlansRoom, plansRoom)
            _ = try repository.deletePlansRoom(of: testPlansRoom.id).toBlocking().first()
            let result = repository.requestPlansRoom(of: testPlansRoom.id).toBlocking().materialize()
            switch result {
            case .completed(elements: let response):
                XCTAssert(response.isEmpty)
            case .failed(elements: let plansRooms, error: let error):
                XCTAssert(plansRooms.isEmpty)
                XCTAssertEqual(error.localizedDescription, RxFirestoreError.documentIsNotExist.localizedDescription)
            }
            repository = nil
        } catch {
            XCTFail(#function + " \(error.localizedDescription)")
        }
    }
}
