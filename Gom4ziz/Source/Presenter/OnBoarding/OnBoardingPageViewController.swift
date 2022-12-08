//
//  OnBoardingPageViewController.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/25.
//

import UIKit

final class OnBoardingPageViewController: UIPageViewController {
    
    private let pageViewControllerList: [UIViewController]
    private let onBoardingViewModel: OnBoardingViewModel

    init(viewControllerList: [UIViewController], onBoardingViewModel: OnBoardingViewModel) {
        self.pageViewControllerList = viewControllerList
        self.onBoardingViewModel = onBoardingViewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
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
        self.dataSource = self
        self.delegate = self
    }
}

// MARK: - Delegate & Datasource

extension OnBoardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let nowViewController = pageViewController.viewControllers?.first else { return }
        guard let previousViewController = previousViewControllers.first else { return }
        guard let previousIndex = pageViewControllerList.firstIndex(of: previousViewController) else { return }
        guard let currentIndex = pageViewControllerList.firstIndex(of: nowViewController) else { return }
        
        print(previousIndex, currentIndex)

        if completed {
            onBoardingViewModel
                .setPageIdx(currentIndex)
        }
    }
}

extension OnBoardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        
        return pageViewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let afterIndex = viewControllerIndex + 1
        guard afterIndex < pageViewControllerList.count else { return nil }
        
        return pageViewControllerList[afterIndex]
    }
}

#if DEBUG
import SwiftUI
struct OnBoardingPageViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: OnBoardingPageViewController(viewControllerList: [OnBoardingFirstViewController()], onBoardingViewModel: OnBoardingViewModel()))
            .toPreview()
    }
}
#endif

