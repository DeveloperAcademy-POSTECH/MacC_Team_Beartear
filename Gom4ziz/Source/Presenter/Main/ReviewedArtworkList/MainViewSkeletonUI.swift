//
//  MainViewSkeletonUI.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/12/04.
//

import UIKit

final class MainViewSkeletonUI: BaseAutoLayoutUIView {

    private let bigRectangle: UIView = .init()
    private let titleRectangle: UIView = .init()
    private let divider: UIView = .init()
    private let firstCell: CellSkeletonView = .init()
    private let secondCell: CellSkeletonView = .init()
    private let thirdCell: CellSkeletonView = .init()

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

}

// MARK: - 프로토콜 설정부분
extension MainViewSkeletonUI {

    func addSubviews() {
        addSubviews(
            bigRectangle,
            titleRectangle,
            divider,
            firstCell,
            secondCell,
            thirdCell
        )
    }

    func setUpConstraints() {
        bigRectangle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bigRectangle.leftAnchor.constraint(equalTo: leftAnchor),
            bigRectangle.rightAnchor.constraint(equalTo: rightAnchor),
            bigRectangle.topAnchor.constraint(equalTo: topAnchor),
            bigRectangle.heightAnchor.constraint(equalToConstant: 400)
        ])

        titleRectangle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleRectangle.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleRectangle.topAnchor.constraint(equalTo: bigRectangle.bottomAnchor, constant: 28),
            titleRectangle.widthAnchor.constraint(equalToConstant: 75),
            titleRectangle.heightAnchor.constraint(equalToConstant: 15)
        ])

        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            divider.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            divider.topAnchor.constraint(equalTo: titleRectangle.bottomAnchor, constant: 9.5),
            divider.heightAnchor.constraint(equalToConstant: 2)
        ])

        firstCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstCell.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 20),
            firstCell.leftAnchor.constraint(equalTo: divider.leftAnchor),
            firstCell.rightAnchor.constraint(equalTo: divider.rightAnchor)
        ])

        secondCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondCell.topAnchor.constraint(equalTo: firstCell.bottomAnchor, constant: 20),
            secondCell.leftAnchor.constraint(equalTo: divider.leftAnchor),
            secondCell.rightAnchor.constraint(equalTo: divider.rightAnchor)
        ])

        thirdCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdCell.leftAnchor.constraint(equalTo: divider.leftAnchor),
            thirdCell.rightAnchor.constraint(equalTo: divider.rightAnchor),
            thirdCell.topAnchor.constraint(equalTo: secondCell.bottomAnchor, constant: 20)
        ])
    }

    func setUpUI() {
        bigRectangle.backgroundColor = .skeleton
        titleRectangle.backgroundColor = .skeleton
        titleRectangle.layer.cornerRadius = 4
        titleRectangle.layer.masksToBounds = true
        divider.backgroundColor = .skeleton
    }

    override func removeFromSuperview() {
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.layer.opacity = 0
        } completion: { _ in
            super.removeFromSuperview()
        }
    }
}

final class CellSkeletonView: BaseAutoLayoutUIView {

    private let bottomDivider: UIView = UIView()
    private let titleRectangle: UIView = UIView()
    private let descriptionRectangle: UIView = UIView()
    private let secondRectangle: UIView = UIView()
    private let imageRectangle: UIView = UIView()

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func addSubviews() {
        addSubviews(
            bottomDivider,
            titleRectangle,
            descriptionRectangle,
            secondRectangle,
            imageRectangle
        )
    }

    func setUpConstraints() {
        titleRectangle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleRectangle.widthAnchor.constraint(equalToConstant: 92),
            titleRectangle.leftAnchor.constraint(equalTo: leftAnchor),
            titleRectangle.heightAnchor.constraint(equalToConstant: 14),
            titleRectangle.topAnchor.constraint(equalTo: topAnchor, constant: 12)
        ])

        imageRectangle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageRectangle.rightAnchor.constraint(equalTo: rightAnchor),
            imageRectangle.widthAnchor.constraint(equalToConstant: 90),
            imageRectangle.topAnchor.constraint(equalTo: topAnchor),
            imageRectangle.heightAnchor.constraint(equalToConstant: 120)
        ])
        descriptionRectangle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionRectangle.leftAnchor.constraint(equalTo: titleRectangle.leftAnchor),
            descriptionRectangle.heightAnchor.constraint(equalToConstant: 16),
            descriptionRectangle.rightAnchor.constraint(equalTo: imageRectangle.leftAnchor, constant: -25),
            descriptionRectangle.topAnchor.constraint(equalTo: titleRectangle.bottomAnchor, constant: 10)
        ])

        secondRectangle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondRectangle.leftAnchor.constraint(equalTo: titleRectangle.leftAnchor),
            secondRectangle.topAnchor.constraint(equalTo: descriptionRectangle.bottomAnchor, constant: 8),
            secondRectangle.heightAnchor.constraint(equalToConstant: 16),
            secondRectangle.rightAnchor.constraint(equalTo: imageRectangle.leftAnchor, constant: -32)
        ])

        bottomDivider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomDivider.leftAnchor.constraint(equalTo: leftAnchor),
            bottomDivider.rightAnchor.constraint(equalTo: rightAnchor),
            bottomDivider.topAnchor.constraint(equalTo: imageRectangle.bottomAnchor, constant: 20),
            bottomDivider.heightAnchor.constraint(equalToConstant: 1),
            bottomDivider.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setUpUI() {
        titleRectangle.backgroundColor = .skeleton
        titleRectangle.layer.cornerRadius = 4
        imageRectangle.backgroundColor = .skeleton
        imageRectangle.layer.cornerRadius = 8
        descriptionRectangle.backgroundColor = .skeleton
        descriptionRectangle.layer.cornerRadius = 4
        secondRectangle.backgroundColor = .skeleton
        secondRectangle.layer.cornerRadius = 4
        bottomDivider.backgroundColor = .skeleton
    }
}

#if DEBUG
import SwiftUI
struct MainViewSkeletonUIPreviews: PreviewProvider {
    static var previews: some View {
        MainViewSkeletonUI().toPreview()
    }
}
#endif
