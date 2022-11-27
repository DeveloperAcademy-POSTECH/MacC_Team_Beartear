//
//  OnBoardingPageViewController.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/25.
//

import UIKit

final class OnBoardingPageViewController: UIPageViewController {
    
    private let pageViewControllerList: [UIViewController]
    
    init(viewControllerList: [UIViewController]) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewControllerList = viewControllerList
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPageViewController()
    }
}

extension OnBoardingPageViewController {
    
    func initPageViewController() {
        guard let firstPage = pageViewControllerList.first else { return }
        setViewControllers([firstPage], direction: .forward, animated: true)
    }
}

#if DEBUG
import SwiftUI
struct OnBoardingPageViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: OnBoardingPageViewController(viewControllerList: [OnBoardingFirstViewController()]))
            .toPreview()
    }
}
#endif

