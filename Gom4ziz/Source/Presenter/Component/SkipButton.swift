//
//  SkipButton.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/28.
//

import UIKit

final class SkipButton: UIButton {
    
    init(text: String) {
        super.init(frame: .zero)
        setUpUI(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension SkipButton {
    
    func setUpUI(text: String) {
        var configuration = UIButton.Configuration.plain()
        let attributes = textStyleAttributes(.Title, .gray3)
        configuration.attributedTitle = AttributedString(text, attributes: attributes)
        self.configuration = configuration
    }
}
