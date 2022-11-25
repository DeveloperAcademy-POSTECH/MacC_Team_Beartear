//
//  BubbleButton.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/24.
//

import UIKit

final class BubbleButton: UIButton {

    init(text: String) {
        super.init(frame: .zero)
        setUpUI(text: text)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path: CGMutablePath = CGMutablePath()
        path.move(to: CGPoint(x: rect.width / 2 - 5, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width / 2, y: rect.height + 8))
        path.addLine(to: CGPoint(x: rect.width / 2 + 5, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width / 2 - 5, y: rect.height))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.gray4.cgColor
        self.layer.insertSublayer(shape, at: 0)
    }

}

private extension BubbleButton {

    func setUpUI(text: String) {
        var configuration: Configuration = .filled()
        configuration.title = text
        configuration.background.backgroundColor = .gray4
        self.configuration = configuration
    }

}

#if DEBUG
import SwiftUI
struct BubbleButtonPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            BubbleButton(text: "삭제")
                .toPreview()
                .frame(width: 50, height: 30)
        }
    }
}
#endif
