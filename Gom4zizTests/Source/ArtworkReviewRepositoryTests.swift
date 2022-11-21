//
//  ArtworkReviewRepositoryTests.swift
//  Gom4zizTests
//
//  Created by JongHo Park on 2022/11/21.
//

@testable import Gom4ziz
import XCTest

import RxTest
import RxBlocking

final class ArtworkReviewRepositoryTests: XCTestCase {

    private var artworkReviewRepository: FirebaseArtworkReviewRepository!
    private var artworkRepository: FirebaseArtworkRepository!
    private let testArtwork: Artwork = Artwork.mockData

    override func setUpWithError() throws {
        try super.setUpWithError()
        artworkRepository = FirebaseArtworkRepository()
        artworkReviewRepository = FirebaseArtworkReviewRepository()
        try artworkRepository.addArtwork(artwork: testArtwork).toBlocking().last()
    }

    override func tearDownWithError() throws {
        try artworkRepository.deleteArtwork(artwork: testArtwork).toBlocking().last()
        artworkReviewRepository = nil
        artworkRepository = nil
        try super.tearDownWithError()
    }

    // TODO: 유저를 추가한 뒤 테스트를 진행해야함!
    func test_아트워크리뷰를_정상적으로_등록하는지() throws {
        // given
        let review: ArtworkReview = .mockData
        // when
        try artworkReviewRepository.addArtworkReview(of: testArtwork.id, review).toBlocking().last()
        let loadedReview = try artworkReviewRepository.fetchArtworkReview(of: testArtwork.id, review.uid).toBlocking().first()
        // then
        XCTAssertEqual(loadedReview, review)
        try artworkReviewRepository.deleteArtworkReview(of: testArtwork.id, review: review).toBlocking().last()
    }
}
