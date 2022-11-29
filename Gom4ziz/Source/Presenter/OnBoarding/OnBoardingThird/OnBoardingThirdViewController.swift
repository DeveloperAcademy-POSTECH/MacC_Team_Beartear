//
//  OnBoardingThirdViewController.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/25.
//

import UIKit

final class OnBoardingThirdViewController: UIViewController {
    
    private let onBoardingThirdView = OnBoardingThirdView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = onBoardingThirdView
    }
}

#if DEBUG
import SwiftUI
struct OnBoardingThirdViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: OnBoardingThirdViewController())
            .toPreview()
    }
}
#endif
