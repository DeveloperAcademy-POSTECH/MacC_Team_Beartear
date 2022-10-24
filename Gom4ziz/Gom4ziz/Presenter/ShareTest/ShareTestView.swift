//
//  ShareTestView.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/10/23.
//

import UIKit

final class ShareTestView: UIView {

    private (set) lazy var shareButton: UIButton = {
        var configuration: UIButton.Configuration = .filled()
        configuration.title = "Share to kakaotalk"
        let button: UIButton = .init()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = configuration
        addSubview(button)
        return button
    }()

    convenience init() {
        self.init(frame: .zero)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("No need to implement")
    }
}

private extension ShareTestView {
    func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            shareButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            shareButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
