//
//  SectionTitleView.swift
//  Gom4ziz
//
//  Created by 정재윤 on 2022/11/23.
//

import UIKit

final class SectionTitleView: UILabel {

    init(title: String) {
        super.init(frame: .zero)
        self.text = title
        self.textStyle(.Headline2, alignment: .left, UIColor.gray4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 아래쪽에 underline을 추가한다.
    /// - Parameter rect: Label을 그릴 영역
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let dividerLayer: CALayer = CALayer()
        dividerLayer.frame = CGRect(x: 0, y: rect.maxY - 2, width: rect.width, height: 2)
        dividerLayer.backgroundColor = UIColor.gray4.cgColor
        layer.insertSublayer(dividerLayer, at: 0)
    }

    /// Text는 원래 그리던 위치에 그대로 그린다 (본질적인 크기를 늘린 만큼 bottom inset을 준다
    /// - Parameter rect: rect
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: .init(top: 0, left: 0, bottom: 9, right: 0)))
    }

    /// UILabel의 본질적인 크기에서 height 를 8만큼 늘린다
    override var intrinsicContentSize: CGSize {
        let superSize = super.intrinsicContentSize
        return CGSize(width: superSize.width, height: superSize.height + 9)
    }
}
