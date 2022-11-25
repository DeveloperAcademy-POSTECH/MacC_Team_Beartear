//
//  OnBoardingButton.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/25.
//

import UIKit

final class OnBoardingButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

#if DEBUG
import SwiftUI
struct OnBoardingButtonPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            OnBoardingButton()
                .toPreview()
                .frame(width: 100, height: 30)
        }
    }
}
#endif

