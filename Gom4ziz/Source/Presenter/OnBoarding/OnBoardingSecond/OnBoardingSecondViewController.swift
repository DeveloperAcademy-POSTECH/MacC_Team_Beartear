//
//  OnBoardingSecondViewController.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/25.
//

import UIKit

final class OnBoardingSecondViewController: UIViewController {
    
    private let onBoardingSecondView = OnBoardingSecondView(urlString: "appGuide")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = onBoardingSecondView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        onBoardingSecondView.guideVideoView.startVideo()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        onBoardingSecondView.guideVideoView.stopVideo()
    }
}

#if DEBUG
import SwiftUI
struct OnBoardingSecondViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: OnBoardingSecondViewController())
            .toPreview()
    }
}
#endif

