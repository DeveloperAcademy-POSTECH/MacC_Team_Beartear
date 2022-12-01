//
//  ToastView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/12/01.
//

import UIKit

final class ToastView: UILabel {

    private let duration: Double
    private let padding: UIEdgeInsets = UIEdgeInsets(top: 16, left: 40, bottom: 16, right: 40)
    private let fadeInOutRatio: Double = 0.04
    private let downScale: CGAffineTransform = CGAffineTransform(scaleX: 0.95, y: 0.95)

    init(
        text: String,
        duration: Double = 2.5,
        alignment: NSTextAlignment = .center
    ) {
        self.duration = duration
        super.init(frame: .zero)
        self.text = text
        setUpUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setUpUI() {
        backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 0.95)
        textStyle(.SubHeadline, lineHeightMultiple: 1, alignment: .center, .white)
        layer.opacity = 0
        layer.cornerRadius = 12
        layer.masksToBounds = true
        numberOfLines = 0
        transform = downScale
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize: CGSize = super.intrinsicContentSize
        contentSize.width += padding.right + padding.left
        contentSize.height += padding.top + padding.bottom

        return contentSize
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0
        ) { [self] in
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: fadeInOutRatio) {
                        self.fadeIn()
                    }
                UIView.addKeyframe(
                    withRelativeStartTime: 1 - fadeInOutRatio,
                    relativeDuration: fadeInOutRatio) {
                        self.fadeOut()
                    }
            } completion: { [self] _ in
                removeFromSuperview()
            }
    }

    private func fadeIn() {
        self.layer.opacity = 1
        self.transform = CGAffineTransform(scaleX: 1, y: 1)
    }

    private func fadeOut() {
        self.layer.opacity = 0
        self.transform = downScale
    }

}

#if DEBUG
import SwiftUI
struct ToastViewPreview: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.red
            ToastView(
                text: "감상문을 성공적으로 저장했습니다."
            ).toPreview()
                .frame(width: 200, height: 0, alignment: .center)
        }
    }
}
#endif
