//
//  OnBoardingSecondViewController.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/25.
//

import AVFoundation
import UIKit

final class OnBoardingSecondViewController: UIViewController {
    
    private let onBoardingSecondView = OnBoardingSecondView(urlString: "appGuide")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(startVieo), name: Notification.Name.onBoardingVideoStart, object: nil)
    }
    
    override func loadView() {
        self.view = onBoardingSecondView
    }
    
    @objc func startVieo() {
        let player =  onBoardingSecondView.guideVideoView.player
        player.seek(to: CMTime.zero)
        player.play()
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

