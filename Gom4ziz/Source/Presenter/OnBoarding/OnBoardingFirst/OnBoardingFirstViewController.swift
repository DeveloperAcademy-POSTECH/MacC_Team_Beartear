//
//  OnBoardingFirstViewController.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/25.
//

import UIKit

final class OnBoardingFirstViewController: UIViewController {
    
    private let onBoardingFirstView = OnBoardingFirstView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = onBoardingFirstView
    }
}

#if DEBUG
import SwiftUI
struct OnBoardingFirstViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: OnBoardingFirstViewController())
            .toPreview()
    }
}
#endif

