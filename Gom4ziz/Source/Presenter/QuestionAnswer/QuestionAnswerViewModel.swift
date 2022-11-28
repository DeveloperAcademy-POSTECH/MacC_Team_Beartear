//
//  QuestionAnswerViewModel.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/23.
//

import RxSwift
import RxRelay

final class QuestionAnswerViewModel {
    let artwork: Artwork
    let artworkDescription: BehaviorRelay<Loadable<ArtworkDescription>> = .init(value: .notRequested)
    var myAnswer: String = ""

    init(of artwork: Artwork) {
        self.artwork = artwork
    }

    // 디버그용 생성자
    #if DEBUG
    init(
        of artwork: Artwork = .mockData,
        artworkDescription: ArtworkDescription = .mockData
    ) {
        self.artwork = artwork
        self.artworkDescription.accept(.loaded(artworkDescription))
    }
    #endif

}
