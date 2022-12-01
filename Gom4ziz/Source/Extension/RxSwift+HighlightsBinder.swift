//
//  RxSwift+HighlightsBinder.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/12/01.
//

import RxCocoa
import RxSwift

extension Reactive where Base: HighlightedTextView {
    var highlightsBinder: Binder<[Highlight]> {
        Binder(base) { target, value in
            target.highlights = value
        }
    }
}
