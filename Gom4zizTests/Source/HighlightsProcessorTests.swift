//
//  HighlightsProcessorTests.swift
//  Gom4zizTests
//
//  Created by JongHo Park on 2022/11/22.
//

@testable import Gom4ziz
import XCTest

final class HighlightsProcessorTests: XCTestCase {

    private let highlightProcessor: HighlightProcessor = HighlightProcessor()

    func test_겹치는_하이라이트가_없으면_그대로_반환() throws {
        // given
        let highlights: [Highlight] = [
            Highlight(start: 20, end: 29),
            Highlight(start: 40, end: 41),
            Highlight(start: 50, end: 90),
            Highlight(start: 130, end: 170),
            Highlight(start: 210, end: 230),
            Highlight(start: 250, end: 280),
            Highlight(start: 281, end: 300),
            Highlight(start: 301, end: 302),
        ]
        // then
        XCTAssertEqual(highlights, highlightProcessor.processHighlights(highlights))
    }

    func test_겹치는_하이라이트가_있다면_제대로_합치는지() throws {
        // given
        let highlights: [Highlight] = [
            Highlight(start: 10, end: 15),
            Highlight(start: 10, end: 13),
            Highlight(start: 10, end: 17),
            Highlight(start: 11, end: 13),
            Highlight(start: 12, end: 13),
            Highlight(start: 13, end: 15), // 여기까지 전부 10 15 로 합쳐짐
            Highlight(start: 17, end: 22), // 17 22
            Highlight(start: 23, end: 45),
            Highlight(start: 30, end: 40), // 23 45
            Highlight(start: 50, end: 70), // 50 70
        ]
        XCTAssertEqual(highlightProcessor.processHighlights(highlights), [
            .init(start: 10, end: 15),
            .init(start: 17, end: 22),
            .init(start: 23, end: 45),
            .init(start: 50, end: 70)
        ])
    }

}
