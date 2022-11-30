//
//  HighlightedTextView+RxRelay.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/30.
//

import RxCocoa
import RxSwift
import RxRelay

extension Reactive where Base: HighlightedTextView {

    var highlights: BehaviorRelay<[Highlight]> {
        let relay: BehaviorRelay = BehaviorRelay(value: base.highlight)
        base.onHighlightsChanged = { highlights in
            relay.accept(highlights)
        }
        return relay
    }

}
