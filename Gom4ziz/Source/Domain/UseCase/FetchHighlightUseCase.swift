//
//  FetchHighlightUseCase.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/22.
//

import Foundation

import RxSwift

protocol FetchHighlightUseCase {
    func fetchHighlight(of artworkId: Int, _ userId: String) -> Observable<[Highlight]>
}

struct RealFetchHighlightUseCase: FetchHighlightUseCase {
    private let highlightRepository: HighlightRepository
    
    init(highlightRepository: HighlightRepository = FirebaseHighlightRepository.shared) {
        self.highlightRepository = highlightRepository
    }
    
    func fetchHighlight(of artworkId: Int, _ userId: String) -> Observable<[Highlight]> {
        highlightRepository.fetchHighlight(of: artworkId, userId)
    }
}
