//
//  PageIndexIndicator.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/28.
//

import UIKit

final class PageIndexIndicatorView: UIView {
    
    private let circleWidth = 8
    private let spaceBetweendots = 8
    private let ellipseWidth = 24
    private var totalCount: Int
    var currentSelectedIndex: Int {
        didSet {
            changeSelectedIndex(currentSelectedIndex)
        }
    }
    private var layers: [CALayer] = []
    private var intrinsicWidth: Int {
        (circleWidth + spaceBetweendots) * (totalCount - 1) + ellipseWidth
    }

    init(
        totalCount: Int,
        currentSelectedIndex: Int = 0
    ) {
        self.totalCount = totalCount
        self.currentSelectedIndex = currentSelectedIndex
        for _ in 0..<totalCount { self.layers.append(CALayer()) }
        super.init(frame: .zero)
        layers.forEach { [self] in
            layer.addSublayer($0)
        }
        for idx in 0..<layers.count {
            displayDots(idx: idx, currentIdx: currentSelectedIndex)
        }
    }
    
    private func displayDots(idx: Int, currentIdx: Int) {
        switch idx {
        case 0..<currentIdx:
            setCircleBeforeEllipse(idx: idx)
        case currentIdx:
            setEllipse(idx: idx)
        default:
            setCircleAfterEllipse(idx: idx)
        }
    }
    
    private func changeSelectedIndex(_ newValue: Int) {
        UIView.animate(withDuration: 1, delay: 0) { [self] in
            for idx in 0..<totalCount {
                displayDots(idx: idx, currentIdx: newValue)
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: intrinsicWidth, height: 8)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension PageIndexIndicatorView {
    
    func afterEllipseXPosition(idx: Int) -> Int {
        (ellipseWidth + spaceBetweendots) * 1 + (circleWidth + spaceBetweendots) * (idx - 1)
    }
    
    func beforeEllipseXPosition(idx: Int) -> Int {
        (circleWidth + spaceBetweendots) * idx
    }
    
    func setCircleBeforeEllipse(idx: Int) {
        layers[idx].frame = CGRect(x: beforeEllipseXPosition(idx: idx), y: 0, width: circleWidth, height: circleWidth)
        layers[idx].backgroundColor = UIColor.gray2.cgColor
        layers[idx].cornerRadius = 4
        layers[idx].masksToBounds = true
    }
    
    func setEllipse(idx: Int) {
        layers[idx].frame = CGRect(x: beforeEllipseXPosition(idx: idx), y: 0, width: ellipseWidth, height: circleWidth)
        layers[idx].backgroundColor = UIColor.gray3.cgColor
        layers[idx].cornerRadius = 4
        layers[idx].masksToBounds = true
    }
    
    func setCircleAfterEllipse(idx: Int) {
        layers[idx].frame = CGRect(x: afterEllipseXPosition(idx: idx), y: 0, width: circleWidth, height: circleWidth)
        layers[idx].backgroundColor = UIColor.gray2.cgColor
        layers[idx].cornerRadius = 4
        layers[idx].masksToBounds = true
    }

}

#if DEBUG
import SwiftUI

struct PageIndexIndicatorViewPreviews: PreviewProvider {
    static var previews: some View {
        VStack {
            PageIndexIndicatorView(totalCount: 4, currentSelectedIndex: 0).toPreview()
                .frame(width: 300, height: 100)
            PageIndexIndicatorView(totalCount: 4, currentSelectedIndex: 1).toPreview()
                .frame(width: 300, height: 100)
            PageIndexIndicatorView(totalCount: 4, currentSelectedIndex: 2).toPreview()
                .frame(width: 300, height: 100)
            PageIndexIndicatorView(totalCount: 4, currentSelectedIndex: 3).toPreview()
                .frame(width: 300, height: 100)
        }
    }
}
#endif
