//
//  ToastView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/12/01.
//

import UIKit

final class ToastView: UIView {

    private let duration: TimeInterval
    private let fadeInOutDuration: TimeInterval = 0.05
    private let downScale: CGAffineTransform = CGAffineTransform(scaleX: 0.95, y: 0.95)

    private let label: UILabel = UILabel()

    init(
        text: String,
        duration: TimeInterval,
        alignment: NSTextAlignment
    ) {
        self.duration = duration
        super.init(frame: .zero)
        setUpUI()
        setUpLabel(text: text, alignment: alignment)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setUpLabel(
        text: String,
        alignment: NSTextAlignment
    ) {
        label.text = text
        label.textStyle(.SubHeadline, lineHeightMultiple: 1, alignment: alignment, .white)
        label.numberOfLines = 0
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
        ])
    }

    private func setUpUI() {
        backgroundColor = .clear
        layer.opacity = 0
        layer.cornerRadius = 12
        layer.masksToBounds = true
        transform = downScale
        setUpBlurEffect()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        animateFadeInOut()
    }

    private func setUpBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        addSubview(visualEffectView)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: topAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            visualEffectView.leftAnchor.constraint(equalTo: leftAnchor),
            visualEffectView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }

    private func animateFadeInOut() {
        let relativeDuration = getRelativeDurationOfFadeInOut()
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0
        ) { [self] in
                UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: relativeDuration) {
                        self.fadeIn()
                    }
                UIView.addKeyframe(
                    withRelativeStartTime: 1 - relativeDuration,
                    relativeDuration: relativeDuration) {
                        self.fadeOut()
                    }
            } completion: { [self] _ in
                removeFromSuperview()
            }
    }

    // ????????? ??????/ ???????????? ????????? 0.05?????? ?????????, ?????? duration?????? 0.05?????? ?????? ????????? ???????????? ??????
    private func getRelativeDurationOfFadeInOut() -> Double {
        fadeInOutDuration / duration
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
            UIImageView(image: UIImage(named: ImageName.bakingSecond)).toPreview()
            ToastView(
                text: "???????????? ??????????????? ??????????????????.",
                duration: 2.5,
                alignment: .center
            ).toPreview()
        }
    }
}
#endif
