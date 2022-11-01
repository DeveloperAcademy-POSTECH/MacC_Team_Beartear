//
//  ShareTestView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/23.
//

import UIKit

final class ShareTestView: BaseAutoLayoutUIView {

    let shareButton: UIButton = {
        var configuration: UIButton.Configuration = .filled()
        configuration.title = "Share to kakaotalk"
        let button: UIButton = .init()
        button.configuration = configuration
        return button
    }()

    convenience init() {
        self.init(frame: .zero)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("No need to implement")
    }
}

extension ShareTestView {

    func addSubviews() {
        addSubview(shareButton)
    }

    func setUpConstraints() {
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            shareButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func setUpUI() {
        backgroundColor = .yellow
    }
}
