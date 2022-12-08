//
//  OnBoardingViewModel.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/27.
//

import Foundation

import RxRelay

final class OnBoardingViewModel {

    let currentPageIdx: BehaviorRelay<Int> = .init(value: 0)
    
    func setPageIdx(_ index: Int) {
        currentPageIdx.accept(index)
    }
}
