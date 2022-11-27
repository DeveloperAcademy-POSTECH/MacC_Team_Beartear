//
//  OnBoardingViewController.swift
//  Gom4ziz
//
//  Created by sanghyo on 2022/11/25.
//

import UIKit

final class OnBoardingViewController: UIViewController {
    
    private let pageViewControllerList = [
        OnBoardingFirstViewController(),
        OnBoardingSecondViewController(),
        OnBoardingThirdViewController()
    ]
    private lazy var pageViewController = OnBoardingPageViewController(viewControllerList: pageViewControllerList)
    private let onBoardingButton = OnBoardingButton(text: "다음으로")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setUpConstraints()
        initPageViewController()
    }
}

private extension OnBoardingViewController {
    
    func setObservers() {
        
    }
    
    func initPageViewController() {
        pageViewController.delegate = self
        pageViewController.dataSource = self
    }
}

private extension OnBoardingViewController {
    
    func addSubviews() {
        addPageViewController()
        view.addSubview(onBoardingButton)
    }
    
    func setUpConstraints() {
        setUpPageViewControllerConstraints()
        setUpOnBoardingButtonConstraints()
    }
}

// MARK: - Constraints

private extension OnBoardingViewController {
    
    func addPageViewController() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    func setUpPageViewControllerConstraints() {
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: onBoardingButton.topAnchor)
        ])
        
    }
    
    func setUpOnBoardingButtonConstraints() {
        onBoardingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onBoardingButton.heightAnchor.constraint(equalToConstant: 60),
            onBoardingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onBoardingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onBoardingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Delegate & Datasource

extension OnBoardingViewController: UIPageViewControllerDelegate {
    
}

extension OnBoardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: pageViewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        
        return pageViewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: pageViewController) else { return nil }
        let afterIndex = viewControllerIndex + 1
        guard afterIndex < pageViewControllerList.count else { return nil }
        
        return pageViewControllerList[afterIndex]
    }
}

#if DEBUG
import SwiftUI
struct OnBoardingViewControllerPreview: PreviewProvider {
    static var previews: some View {
        UINavigationController(rootViewController: OnBoardingViewController())
            .toPreview()
    }
}
#endif

