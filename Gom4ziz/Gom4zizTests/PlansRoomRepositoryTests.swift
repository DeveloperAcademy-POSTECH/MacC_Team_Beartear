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
        try super.tearDownWithError()
    }

    func testFetchPlansRoomList() async throws {
        do {
            // add
            _ = try repository.addPlansRoom(for: testPlansRoom).toBlocking().first()
            guard let rooms = try repository.fetchPlansRoomList(for: "123").toBlocking().first() else {
                XCTFail(#function + " plans room should be exist!!")
                return
            }
            XCTAssertEqual(rooms.first?.id, "1111")
            _ = try repository.deletePlansRoom(of: testPlansRoom.id).toBlocking().first()
            let result = repository.fetchPlansRoomList(for: "123").toBlocking().materialize()
            switch result {
            case .completed(elements: let response):
                XCTAssert(response.first!.isEmpty)
            case .failed(elements: let plansRooms, error: let error):
                XCTAssert(plansRooms.isEmpty)
                XCTAssertEqual(error.localizedDescription, RxFirestoreError.documentIsNotExist.localizedDescription)
            }
            repository = nil
        } catch {
            XCTFail(#function + " \(error.localizedDescription)")
        }
    }

    func testAddRequestDeletePlansRoom() throws {
        do {
            // add
            _ = try repository.addPlansRoom(for: testPlansRoom).toBlocking().first()
            // request
            guard let rooms = try repository.fetchPlansRoomList(for: "123").toBlocking().first() else {
                XCTFail(#function + " plans room should be exist!!")
                return
            }

            // delete
            XCTAssertEqual(testPlansRoom, rooms.first!)
            _ = try repository.deletePlansRoom(of: testPlansRoom.id).toBlocking().first()
            let result = repository.fetchPlansRoomList(for: "123").toBlocking().materialize()
            switch result {
            case .completed(elements: let response):
                XCTAssert(response.first!.isEmpty)
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
            guard let rooms = try repository.fetchPlansRoomList(for: "123").toBlocking().first() else {
                XCTFail(#function + " plans room should be exist!!")
                return
            }

            // update
            XCTAssertEqual(testPlansRoom.id, rooms.first?.id)
            _ = try repository.updatePlansRoom(for: rooms.first!).toBlocking().first()
            let result = repository.fetchPlansRoomList(for: "123").toBlocking().materialize()
            switch result {
            case .completed(elements: let response):
                XCTAssertFalse(response.isEmpty)
            case .failed(elements: let plansRooms, error: let error):
                XCTAssertFalse(plansRooms.isEmpty)
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
            guard let rooms = try repository.fetchPlansRoomList(for: "123").toBlocking().first() else {
                XCTFail(#function + " plans room should be exist!!")
                return
            }

            // update
            XCTAssertEqual(testPlansRoom, rooms.first!)
            _ = try repository.updatePlansRoom(for: rooms.first!).toBlocking().first()

            // request
            guard let otherRooms = try repository.fetchPlansRoomList(for: "123").toBlocking().first() else {
                XCTFail(#function + " plans room should be exist!!")
                return
            }

            // delete
            XCTAssertEqual(testPlansRoom, otherRooms.first!)
            _ = try repository.deletePlansRoom(of: testPlansRoom.id).toBlocking().first()
            let result = repository.fetchPlansRoomList(for: "123").toBlocking().materialize()
            switch result {
            case .completed(elements: let response):
                XCTAssert(response.first!.isEmpty)
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
