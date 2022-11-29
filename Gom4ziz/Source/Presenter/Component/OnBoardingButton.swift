//
//  OnBoardingButton.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/25.
//

import UIKit

final class OnBoardingButton: UIButton {
    
    init(text: String) {
        super.init(frame: .zero)
        setUpUI(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension OnBoardingButton {
    
    func setUpUI(text: String) {
        var configuration = UIButton.Configuration.filled()
        let attributes = textStyleAttributes(.Headline1, .white)
        configuration.attributedTitle = AttributedString(text, attributes: attributes)
        configuration.background.backgroundColor = .gray4
        configuration.background.cornerRadius = 0
        self.configuration = configuration
    }
}

#if DEBUG
import SwiftUI
struct OnBoardingButtonPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            OnBoardingButton(text: "다음")
                .toPreview()
                .frame(width: UIScreen.main.bounds.width, height: 50)
        }
    }
}
#endif
